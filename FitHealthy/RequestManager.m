//
//  RequestManager.m
//  FitHealthy
//
//  Created by MacBook on 19/07/15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager



+(void)getFromServer:(NSString*)api parameters:(NSMutableDictionary*)parameters completionHandler:(RequestManagerHandler)handler{
    
    NSArray *temp = [[NSArray alloc] init];
    
    temp = [parameters allKeys];
    NSString *paramterString=@"";
    
    NSEnumerator *e = [temp objectEnumerator];
    
    id object;
    while (object = [e nextObject]) {
       // [dict setValue:[dictObject objectForKey:object] forKey:object];
        paramterString=[[[[paramterString stringByAppendingString:object] stringByAppendingString:@"="]stringByAppendingString:[parameters objectForKey:object]]stringByAppendingString:@"&"];
    }
    
    paramterString=[paramterString substringToIndex:paramterString.length-1];
    NSLog(@"%@parameter string",paramterString);
    //NSString *postString = [NSString stringWithFormat:@"current_timestamp=%@",@"now"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseUrl,api];
    
    
    NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSData* bodyData = [paramterString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:bodyData];
    
    
    [FHDelegate show_LoadingIndicator];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
     
     {
         
         [FHDelegate hide_LoadingIndicator];
         
         if(error != nil)
             
         {
             
             NSLog(@"NSURLConnection Error :- %@", [error description]);
             
             
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Please Check Your Internet Connection." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             
             [alert show];
             
             
             NSMutableDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"serverError", nil];
             handler(dict);
             return ;
         }
         //return;
         
//         NSString* responseStr = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
//         
//         NSLog(@"ResponseStr is --> %@", responseStr);
         
         
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 //NSDictionary* responseDict = [data objectFromJSONData];
                 NSError* error;
                 NSMutableDictionary *responseDict=[NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data
                                                                                                                                 options:kNilOptions error:&error]];
                 NSLog(@"Parsed");
                 dispatch_async(dispatch_get_main_queue(), ^{
                 if(handler != nil && responseDict != nil)
                 handler(responseDict);
                 NSLog(@"Parse and send");
             });
             });
         
     }];

}



+(void)postWithImageServer:(NSString*)api parameters:(NSMutableDictionary*)parameters  image:(UIImage*)image imageName:(NSString*)imageNamge completionHandler:(RequestManagerHandler)handler{
    NSArray *temp = [[NSArray alloc] init];
    
    temp = [parameters allKeys];
    NSString *paramterString=@"";
    
    NSEnumerator *e = [temp objectEnumerator];
    
    id object;
    while (object = [e nextObject]) {
        // [dict setValue:[dictObject objectForKey:object] forKey:object];
        paramterString=[[[[paramterString stringByAppendingString:object] stringByAppendingString:@"="]stringByAppendingString:[parameters objectForKey:object]]stringByAppendingString:@"&"];
    }
    
    paramterString=[paramterString substringToIndex:paramterString.length-1];
    NSLog(@"%@parameter string",paramterString);
    //NSString *postString = [NSString stringWithFormat:@"current_timestamp=%@",@"now"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseUrl,api];
    
    
    NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    //[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    
       
    NSString *BoundaryConstant = @"---------------------------0xKhTmLbOuNdArY";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in temp) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", imageNamge] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    
       [FHDelegate show_LoadingIndicator];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
     
     {
         
         [FHDelegate hide_LoadingIndicator];
         
         if(error != nil)
             
         {
             
             NSLog(@"NSURLConnection Error :- %@", [error description]);
             
             
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Please Check Your Internet Connection." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             
             [alert show];
             
             //return;
             NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"error", nil];
             handler(dict);
         }
         
         
                  NSString* responseStr = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
         //
                  NSLog(@"ResponseStr is --> %@", responseStr);
         
         
         NSMutableDictionary *responseDict=[NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data
                                                                                                                         options:kNilOptions error:&error]];
         
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             NSLog(@"Parsed");
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(handler != nil && responseDict != nil)
                     handler(responseDict);
                 NSLog(@"Parse and send");
             });
         });
         
     }];

}

+(void)sessionLogin:(NSString*)api parameters:(NSMutableDictionary*)parameters completionHandler:(RequestManagerHandler)handler{
    NSArray *temp = [[NSArray alloc] init];
    
    temp = [parameters allKeys];
    NSString *paramterString=@"";
    
    NSEnumerator *e = [temp objectEnumerator];
    
    id object;
    while (object = [e nextObject]) {
        // [dict setValue:[dictObject objectForKey:object] forKey:object];
        paramterString=[[[[paramterString stringByAppendingString:object] stringByAppendingString:@"="]stringByAppendingString:[parameters objectForKey:object]]stringByAppendingString:@"&"];
    }
    
    paramterString=[paramterString substringToIndex:paramterString.length-1];
    NSLog(@"parameter string=%@",paramterString);
    //NSString *postString = [NSString stringWithFormat:@"current_timestamp=%@",@"now"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseUrl,api];
    
    NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSData* bodyData = [paramterString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:bodyData];
    
     [FHDelegate show_LoadingIndicator];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
     
     {
         
         if(error != nil)
             
         {
             
             NSLog(@"NSURLConnection Error :- %@", [error description]);
             NSLog(@"code=%d",[error code]);
             
             
             NSMutableDictionary *dict;
             if ([error code] == -1009) {
                 dict =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"requestStatus", nil];
                 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Please Check Your Internet Connection." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 [alert show];
                 [FHDelegate hide_LoadingIndicator];
             }
             else if ([error code] == -1012 || [error code] == -1005){
                 
                 if (FHDelegate.requestCount==4) {
                     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Please Try After Sometime." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     
                     [alert show];
                     dict =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"requestStatus", nil];
                     [FHDelegate hide_LoadingIndicator];
                     FHDelegate.requestCount=0;
                     handler(dict);
                     return ;
                 }
                 dict =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"requestStatus", nil];
                 FHDelegate.requestCount++;
             }
             
             
             handler(dict);
             return ;

         }
         
         [FHDelegate hide_LoadingIndicator];
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             NSError* error;
             
    NSMutableDictionary *responseDict=[NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data
                                                                                                                             options:kNilOptions error:&error]];
             NSLog(@"Parsed");
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(handler != nil && responseDict != nil)
                     handler(responseDict);
                 NSLog(@"Parse and send");
             });
         });
         
     }];

}


+(void)configureApp:(RequestManagerHandler)handler{
    
    NSString *urlString = [NSString stringWithFormat:@"%@",BaseUrl];
    
     urlString=[urlString substringToIndex:urlString.length-1];
    NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    [FHDelegate show_LoadingIndicatorConfigure];
   
    NSData* bodyData = [@"current_timestamp=now" dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse* response, NSData* data, NSError* error)
     
     {
         
         
         if(error != nil)
             
         {
             
             NSLog(@"NSURLConnection Error :- %@", [error description]);
             NSLog(@"code=%d",[error code]);
             
             
             NSMutableDictionary *dict;
             if ([error code] == -1009) {
                 dict =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"requestStatus", nil];
                 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Please Check Your Internet Connection." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 [alert show];
                  [FHDelegate hide_LoadingIndicatorConfigure];
             }
             else if ([error code] == -1012 || [error code] ==-1005){
                 
                 if (FHDelegate.requestCount==4) {
                     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Please Try After Sometime." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     
                     [alert show];
                     dict =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"requestStatus", nil];
                     [FHDelegate hide_LoadingIndicatorConfigure];
                     FHDelegate.requestCount=0;
                     handler(dict);
                     return ;
                 }
                 dict =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"requestStatus", nil];
                 FHDelegate.requestCount++;
             }
             
             
             handler(dict);
             return ;
         }
         
         [FHDelegate hide_LoadingIndicatorConfigure];
         
         
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError* error;
             
             NSMutableDictionary *responseDict=[NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data
                                                                                                                             options:kNilOptions error:&error]];
             NSLog(@"Parsed");
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(handler != nil && responseDict != nil)
                     handler(responseDict);
                 NSLog(@"Parse and send");
             });
         });
         
     }];

}


@end
