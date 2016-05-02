

#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "FHAppDelegate.h"
// Add to top of file
NSString *const IAPHelperProductPurchasedNotification = @"IAPHelperProductPurchasedNotification";

// 2
@interface IAPHelper () <SKProductsRequestDelegate, SKPaymentTransactionObserver>
@end

@implementation IAPHelper {
    // 3
    SKProductsRequest * _productsRequest;
    // 4
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    if ((self = [super init])) {
        
        _productIdentifiers=productIdentifiers;
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"purchase" message:@"Successfull purchase" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [alert show];
    
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    };
}


- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"completeTransaction...%@",transaction.payment.productIdentifier);
    
    NSLog(@"Transactions is complete");
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSDictionary *userinfo=[NSDictionary dictionaryWithObjectsAndKeys:@"success",@"status",transaction.payment.productIdentifier,@"type", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TransactionNotificaiton" object:self userInfo:userinfo];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"restoreTransaction...");
    
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
     [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
   

    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:transaction.error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    
    [self cancelledOrError:transaction];
    
    
}


-(void)cancelledOrError:(SKPaymentTransaction*)transaction {
    
    NSDictionary *userinfo=[NSDictionary dictionaryWithObjectsAndKeys:@"failed",@"status",transaction,@"type", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TransactionNotificationFailed" object:nil userInfo:userinfo];
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    
    // 1
    _completionHandler = [completionHandler copy];
    
    // 2
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    NSArray * skProducts = response.products;
    for (SKProduct * skProduct in skProducts) {
        NSLog(@"Found product: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
        
            [FHDelegate.productDict setObject:skProduct forKey:skProduct.productIdentifier];
       
    }
    
    
    
        
    _completionHandler(YES, skProducts);
    _completionHandler = nil;
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}



- (void)buyProduct:(SKProduct *)product {
    
    NSLog(@"Buying product IAP %@...", product.productIdentifier);
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}


@end
