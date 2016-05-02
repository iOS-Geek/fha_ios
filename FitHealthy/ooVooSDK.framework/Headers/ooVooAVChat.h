//
// ooVooAVChat.h
//
// Created by ooVoo on May 17, 2015
//
// © 2015 ooVoo, LLC.  Used under license.
//
// This product includes software from the following open source projects:
//
// Google WebM project:
// http://www.webmproject.org/license/bitstream/
// http://www.webmproject.org/license/software/
// http://www.webmproject.org/license/additional/
// Copyright (c) 2010, Google Inc. All rights reserved.
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// •         Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// •         Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// •         Neither the name of Google nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// OpenSSL project:
// http://www.openssl.org/source/license.html
// Copyright (c) 1998-2011 The OpenSSL Project.  All rights reserved.
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software must display the following acknowledgment: "This product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit. (http://www.openssl.org/)"
// 4. The names "OpenSSL Toolkit" and "OpenSSL Project" must not be used to endorse or promote products derived from this software without prior written permission. For written permission, please contact openssl-core@openssl.org.
// 5. Products derived from this software may not be called "OpenSSL" nor may "OpenSSL" appear in their names without prior written permission of the OpenSSL Project.
// 6. Redistributions of any form whatsoever must retain the following acknowledgment: "This product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit (http://www.openssl.org/)"
// THIS SOFTWARE IS PROVIDED BY THE OpenSSL PROJECT ``AS IS'' AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE OpenSSL PROJECT OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// This license also includes a requirement to comply with the “Original SSLeay License,” which includes the following terms:
// This library is free for commercial and non-commercial use as long as the following conditions are adhered to.  The following conditions apply to all code found in this distribution, be it the RC4, RSA, lhash, DES, etc., code; not just the SSL code.  The SSL documentation included with this distribution is covered by the same copyright terms except that the holder is Tim Hudson (tjh@cryptsoft.com).
// Copyright remains Eric Young's, and as such any Copyright notices in the code are not to be removed.  If this package is used in a product, Eric Young should be given attribution as the author of the parts of the library used.  This can be in the form of a textual message at program startup or in documentation (online or textual) provided with the package.
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the copyright notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software must display the following acknowledgement:  "This product includes cryptographic software written by Eric Young (eay@cryptsoft.com)" The word 'cryptographic' can be left out if the routines from the library being used are not cryptographic related :-).
// 4. If you include any Windows specific code (or a derivative thereof) from the apps directory (application code) you must include an acknowledgement: "This product includes software written by Tim Hudson (tjh@cryptsoft.com)"
// THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// The license and distribution terms for any publically available version or derivative of this code cannot be changed.  i.e. this code cannot simply be copied and put under another distribution license [including the GNU Public License.]

// boost:
// http://www.boost.org/users/license.html
// Boost Software License – Version 1.0 – August 17th, 2003
// Permission is hereby granted, free of charge, to any person or organization obtaining a copy of the software and accompanying documentation covered by this license (the ‘Software”) to use, reproduce, display, distribute, execute, and transmit the Software, and to prepare derivative works of the Software, and to permit third-parties to whom the Software is furnished to do so, all subject to the following:
// The copyright notices in the Software and this entire statement, including the above license grant, this restriction and the following disclaimer, must be included in all copies of the Software, in whole or in part, and all derivative works of the software, unless such copies or derivative works are solely in the form of machine-executable object code generated by a source language processor.
// The software is provided “as is”, without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, title and non-infringement. In no event shall the copyright holders or anyone distributing the software be liable for any damages or other liability, whether in contract, tort or otherwise arising from, out of or in connection with the software or the use or other dealings in the software.

// LibYuv project:
// https://github.com/lemenkov/libyuv/blob/master/LICENSE
// Copyright 2011 The LibYuv Project Authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// o   Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// o   Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// o   Neither the name of Google nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// UTF8 convert:
// Permission is hereby granted, free of charge, to any person or organization obtaining a copy of the software and accompanying documentation covered by this license (the “Software”) to use, reproduce, display, distribute, execute, and transmit the Software, and to prepare derivative works of the Software, and to permit third-parties to whom the Software is furnished to do so, all subject to the following:
// The copyright notices in the Software and this entire statement, including the above license grant, this restriction and the following disclaimer, must be included in all copies of the Software, in whole or in part, and all derivative works of the Software, unless such copies or derivative works are solely in the form of machine-executable object code generated by a source language processor.
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.”
//
//
#import <Foundation/Foundation.h>
#import "ooVooClientApi.h"
#import "errors_objc.h"
#import "SdkResult.h"

typedef NS_ENUM(int,ooVooAudioRouteType)
{
    ooVooAudioToEarpiece        = 0 ,
    ooVooAudioRouteToHeadphones = 1 ,
    ooVooAudioRouteToBluetooth  = 2 ,
    ooVooAudioRouteToSpeaker   ,
};


#define OOVOOAudioModeVoiceChat "voice"
#define OOVOOAudioModeVideoChat "video"

extern NSString* const OOVOOAudioRouteDidChangeNotification; 
extern NSString* const OOVOOAudioRouteNameKey;
extern NSString* const OOVOOAudioRouteTypeKey;




typedef NS_ENUM(int, ooVooVideoControllerConfigKey) {
    ooVooVideoControllerConfigKeyCaptureDeviceId,
    ooVooVideoControllerConfigKeyResolution,
    ooVooVideoControllerConfigKeyFps,
    ooVooVideoControllerConfigKeyEffectId
};


typedef NS_ENUM  (int, ResolutionLevel)
{
    ResolutionLevelNotSpecified = 0,
    ResolutionLevelLow = 1,
    ResolutionLevelMed = 2,
    ResolutionLevelHigh = 3,
    ResolutionLevelHD = 4
};

typedef NS_ENUM(int, ooVooPstnState) {
    ooVooPstnStateStartCall,
    ooVooPstnStateEndCall,
    ooVooPstnStateInProgress,
    ooVooPstnStateRinging,
    ooVooPstnStateCalIsBeingForwarded,
    ooVooPstnStateQueued,
    ooVooPstnStateSessionInProgress,
    ooVooPstnStateOK,
    ooVooPstnStateBadRequest,
    ooVooPstnStatePaymentRequired,
    ooVooPstnStateNotFound,
    ooVooPstnStateRequestTimedOut,
    ooVooPstnStateConnectionTimeOut,
    ooVooPstnStateTooManyPstnClients,
    ooVooPstnStateInvalidPhoneNumber,
    ooVooPstnStateInfrastructureError
};



typedef NS_ENUM(int, ooVooAudioControllerConfigKey) {
    ooVooAudioControllerConfigKeyRenderDeviceId,
    ooVooAudioControllerConfigKeyCaptureDeviceId,
    ooVooAudioControllerConfigKeyAudioSetMode
};

typedef NS_ENUM(int, ooVooMediaooVooDeviceType) {
    ooVooMediaooVooDeviceTypeUnspecified = 0,
    ooVooMediaooVooDeviceTypeCamera = 1,     // Camera video input device.
    ooVooMediaooVooDeviceTypeMicrophone = 2, // Microphone audio input device.
    ooVooMediaooVooDeviceTypeSpeaker = 3,    // Speaker audio output device.
    ooVooMediaooVooDeviceTypeAll = 4         // All ooVooDevices
};

typedef NS_ENUM(int, ooVooAVChatState) {
    ooVooAVChatStateJoined,      //!< Local user joined to conference
    ooVooAVChatStateDisconnected //!< Local user disconnect form conference , see error code for reason
};

typedef NS_ENUM(int, ooVooAVChatRemoteVideoState) {
    ooVooAVChatRemoteVideoStateStarted, //!< Remote video started.
    ooVooAVChatRemoteVideoStateStopped, //!< Remote video stopped.
    ooVooAVChatRemoteVideoStatePaused,  //!< Remote video paused by QOS/hold.
    ooVooAVChatRemoteVideoStateResumed  //!< Remote video resumed by QOS.
};

typedef NS_ENUM(int, ooVooAVParticipantType) {
    ooVooAVParticipantTypeVOIP,
    ooVooAVParticipantTypePSTN
};

@protocol ooVooParticipant <NSObject>
@required
@property (readonly, getter=participantID) NSString *participantID;
@property (readonly, getter=participantType) ooVooAVParticipantType type;
@end

@protocol ooVooDevice <NSObject>
@required
@property (readonly, getter=deviceName) NSString *deviceName;
@property (readonly, getter=deviceID) NSString *deviceID;
@end

@protocol ooVooVideoDevice <NSObject,ooVooDevice>
@required
-(BOOL) isResolutionSuported :(ResolutionLevel) resolution ;
-(BOOL) isFront ;
-(NSArray*) getAvailableResolutions ;  
@end


@protocol ooVooEffect <NSObject>
@required
@property (readonly, getter=effectName) NSString *effectName;
@property (readonly, getter=effectID) NSString *effectID;
@property (readonly, getter=iconUrl) NSString *iconUrl;
@end

@protocol ooVooAudioControllerDelegate
@required

/**
 *  listener method is being called when audio transmit state was changed.
 *  @param state - new audio transmit state (ON/OFF).
 *  @param errorCode - conference error code.
 */
- (void)didAudioTransmitStateChange:(BOOL)state error:(sdk_error)code;

/**
 *  listener method is being called when audio receive state was changed.
 *  @param state - new audio receive state (ON/OFF).
 *  @param errorCode - conference error code.
 */
- (void)didAudioReceiveStateChange:(BOOL)state error:(sdk_error)code;

@end

@protocol ooVooAudioController <NSObject>
@property (atomic, retain) id<ooVooAudioControllerDelegate> delegate;
@required

/**
 * Init audio for a session
 */
- (void)initAudio:(CompletionHandler)complition;
- (BOOL)isPlaybackMuted;
- (void)setPlaybackMute:(BOOL)flag;
- (BOOL)isRecordMuted;
- (void)setRecordMuted:(BOOL)recordEnable;
- (void)setConfig:(NSString *)val forKey:(ooVooAudioControllerConfigKey)key;
- (NSString *)getConfig:(ooVooAudioControllerConfigKey)key;

@end




@protocol ooVooVideoRender <NSObject>
#if TARGET_OS_IPHONE
- (UIViewController *)viewController ;
#endif
@end

@protocol ooVooVideoControllerDelegate <NSObject>
@required

/**
 *  listener method is being called when remote video state has changed.
 *  @param uid -user id of remote video.
 *  @param state - new remote video state.
 *  @param width - picture width.
 *  @param height - picture height.
 *  @param errorCode - conference error code.
 */
- (void)didRemoteVideoStateChange:(NSString *)uid state:(ooVooAVChatRemoteVideoState)state width:(const int)width height:(const int)height error:(sdk_error)code;

/**
 *  listener method is being called when camera state was changed.
 *  @param state - new camera state (ON/OFF).
 *  @param errorCode - conference error code.
 */
- (void)didCameraStateChange:(BOOL)state devId:(NSString *)devId width:(const int)width height:(const int)height fps:(const int)fps error:(sdk_error)code;

/**
 *  listener method is being called when video transmit state was changed.
 *  @param state - new video transmit state (ON/OFF).
 *  @param errorCode - conference error code.
 */
- (void)didVideoTransmitStateChange:(BOOL)state devId:(NSString *)devId error:(sdk_error)code;

/**
 *  listener method is being called when preview video state was changed.
 *  @param state - new preview video state (ON/OFF).
 *  @param errorCode - conference error code.
 */
- (void)didVideoPreviewStateChange:(BOOL)state devId:(NSString *)devId error:(sdk_error)code;

@end

@protocol ooVooVideoController <NSObject>
@property (atomic, retain) id<ooVooVideoControllerDelegate> delegate;
@property (atomic, setter=setActiveDevice:, getter=getActiveDevice) id<ooVooVideoDevice> activeDevice;
@required

/**
*  set which camera to open front / back
*  @param val - camera Id.
*  enum  ooVooVideoControllerConfigKey = kCaptureooVooDeviceId , for camera ...
*/
- (void)setConfig:(NSString *)val forKey:(ooVooVideoControllerConfigKey)key;
- (NSString *)getConfig:(ooVooVideoControllerConfigKey)key;

// can be called before join
- (void)openPreview;
- (void)closePreview;

- (void)openCamera;
- (void)closeCamera;

// can be called after join succeed
- (void)startTransmitVideo;
- (void)stopTransmitVideo;

- (BOOL)isVideoTransmited;

- (void)bindVideoRender:(NSString *)uid render:(id<ooVooVideoRender>)render;
- (void)unbindVideoRender:(NSString *)uid render:(id<ooVooVideoRender>)render;

- (void)registerRemoteVideo:(NSString *)uid;
- (void)unRegisterRemoteVideo:(NSString *)uid;

- (NSArray *)getDevicesList;
- (NSArray *)getEffectsList;
- (id<ooVooVideoDevice>) getActiveDevice ;
-(void) setActiveDevice:(id<ooVooVideoDevice>) device ;
-(ResolutionLevel) sizeToCameraResolutionLevel:(int)width picHeight:(int) height;


@end

@protocol ooVooPluginFactory <NSObject>
@required
- (void *)getooVooPluginFactoryNative;
@end

@protocol ooVooAVChatDelegate <NSObject>
/**
 *  listener method is being called when new participant joined conference.
 *  @param uid - user id of new participant.
 *  @param userData - user data.
 */
- (void)didParticipantJoin:(id<ooVooParticipant>)participant user_data:(NSString *)user_data;

/**
 *  listener method is being called when new participant left conference.
 *  @param uid - user id of participant.
 */
- (void)didParticipantLeave:(id<ooVooParticipant>)participant;



/**
 *  listener method is being called when conference state has changed.
 *  @param state - new conference state.
 *  @param errorCode - conference error code.
 */
- (void)didConferenceStateChange:(ooVooAVChatState)state error:(sdk_error)code;

/**
 *  listener method is being called when message is received.
 *  @param uid -user id of remote video.
 *  @param buffer - data which contains the message.
 *  @param size - buffer size.
 */
- (void)didReceiveData:(NSString *)uid data:(NSData *)data;

/**
 *  listener method is being called when conference error is received.
 *  @param errorCode - conference error code.
 */
- (void)didConferenceError:(sdk_error)code;

/**
 *  listener method is being called when network reilability change.
 *  @param score - a number from 1 - 4  1 indicate that network is worse 4 network is best.
 */
- (void)didNetworkReliabilityChange:(NSNumber*)score ;

@end

@protocol ooVooAVChat <NSObject>

@property (atomic, retain) id<ooVooAVChatDelegate> delegate;
@property (setter=setSslVerifyPeer:,getter=isSslVerifyPeer) BOOL sslVerifyPeer ;
@property (readonly, getter=isInCallMessagePermit) BOOL isInCallMessagePermit ;
@property (readonly, getter=get_audiocontroller) id<ooVooAudioController> AudioController;
@property (readonly, getter=get_videocontroller) id<ooVooVideoController> VideoController;

- (void)join:(NSString *)cid user_data:(NSString *)data;
- (void)joinDirect:(NSString *)server_ip conference_id:(NSString *)cid;
- (void)leave;
- (void)sendData:(NSString *)uid message:(NSData *)message completion:(CompletionHandler)completion;
- (void)sendData:(NSData *)message completion:(CompletionHandler)completion;
- (void)registerPlugin:(id<ooVooPluginFactory>)plugin;
- (void)unregisterPlugin:(id<ooVooPluginFactory>)plugin;
- (void)setSslVerifyPeer:(BOOL) state ;
- (BOOL)isSslVerifyPeer ;
- (NSString *)getUserFullName;
-(BOOL) isResolutionSuported :(ResolutionLevel) resolution ;
@end
