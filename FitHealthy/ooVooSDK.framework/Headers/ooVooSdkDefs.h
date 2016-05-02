//
// ooVooSdkDefs.h
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
#ifndef _OOVOO_SDK_DEFS_
#define _OOVOO_SDK_DEFS_

#if defined(WIN32) || defined(WINAPI_FAMILY)
# pragma warning(disable:4250)
#endif



#ifdef LIBRARY_IMPL
#define PRX_INTERFACE __declspec(dllexport)
#else
#if !defined(TARGET_OS_MAC) && !defined(__ANDROID__) && !defined(WINAPI_FAMILY)
#define PRX_INTERFACE __declspec(dllimport)
#endif
#endif

#ifndef PRX_INTERFACE
#define PRX_INTERFACE
#endif


#include <vector>
#include <algorithm>
#include <sstream>
#include "errors.h"

namespace oovoo {
namespace sdk {

#define _MAKE_PLATFORM_ENUM_(name, ...) enum class name { __VA_ARGS__, __COUNT}; \
    inline std::ostream& operator<<(std::ostream& os, name value) \
        { \
        std::string enumName = #name; \
        std::string str = #__VA_ARGS__; \
        size_t len = str.length(); \
        std::vector<std::string> strings; \
        std::ostringstream temp; \
        for(size_t i = 0; i < len; i ++) \
                                        { \
            if(isspace(str[i])) continue; \
                                                                                                                                                                                                else if(str[i] == ',') \
                { \
                strings.push_back(temp.str()); \
                temp.str(std::string());\
                } \
                                                                                                                                                                                                else temp<< str[i]; \
                                        } \
        strings.push_back(temp.str()); \
        std::string valuetoback = strings[static_cast<int>(value)]; \
        std::replace( valuetoback.begin(), valuetoback.end(), '_', '/'); \
        os<<valuetoback; \
        return os; \
        }\
 

enum class InitResult
{
	NotInited = -1,
	InitOk = 0,
	InitFail,
	InitFailApplicationTokenInvalid,
	AlreadyInited
};


enum class LogLevel
{
	None = 0,
	Fatal = 1,
	Error = 2,
	Warning = 3,
	Info = 4,
	Debug = 5,
	Trace = 6
};

enum class AccountState
{
	ACCOUNT_LOGGED_IN,
	ACCOUNT_LOGGED_OUT
};

enum class DeviceType
{
	Unspecified = 0,
	Camera = 1,         // Camera video input device.
	Microphone = 2,     // Microphone audio input device.
	Speaker = 3,        // Speaker audio output device.
	All = 4             // All Devices
};

enum class VideoConfigKey
{
	kVideoCfgCaptureDeviceId,
	kVideoCfgResolution,
	kVideoCfgFps,
	kVideoCfgEffectId
};

enum class AudioConfigKey
{
	kAudioCfgRenderDeviceId,
	kAudioCfgCaptureDeviceId,
    kAudioCfgAudioSetMode
};

////////////////////////////////////////////////////////////////////////////////////////////////////
/// \brief ooVoo SDK conference remote video states.
////////////////////////////////////////////////////////////////////////////////////////////////////
enum class RemoteVideoState
{
	RVS_Started,        //!< Remote video started.
	RVS_Stopped,        //!< Remote video stopped.
	RVS_Paused,         //!< Remote video paused by QOS/hold.
	RVS_Resumed         //!< Remote video resumed by QOS.
};


////////////////////////////////////////////////////////////////////////////////////////////////////
/// \brief ooVoo SDK ON and OFF states.
////////////////////////////////////////////////////////////////////////////////////////////////////

enum class _Boolean
{
	OFF = 0, ON = 1
};


////////////////////////////////////////////////////////////////////////////////////////////////////
/// \brief ooVoo SDK media device types.
////////////////////////////////////////////////////////////////////////////////////////////////////

enum class MediaDeviceType
{
	UNSPECIFIED_DEVICE = 0,     //!< Unspecified device.
	VIDEO_DEVICE = 1,           //!< Video input device.
	AUDIO_INPUT_DEVICE = 2,     //!< Audio input device.  (Mic)
	AUDIO_OUTPUT_DEVICE = 3,    //!< Audio output device. (Speaker)
};


_MAKE_PLATFORM_ENUM_(FriendPresence, FRIEND_AVAILABLE, FRIEND_BUSY, FRIEND_AWAY, FRIEND_INBISIBLE, FRIEND_UNAVAILABLE);

_MAKE_PLATFORM_ENUM_(GenderType, MALE, FEMALE);

_MAKE_PLATFORM_ENUM_(MessageState, SENT, DELIVERED, READED, FAILED);

_MAKE_PLATFORM_ENUM_(FriendNegotation, NEGOTATION_UNDEFINED, NEGOTATION_SUBSCRIBE, NEGOTATION_SUBSCRIBED, NEGOTATION_UNSUBSCRIBE, NEGOTATION_UNSUBSRIBED);

_MAKE_PLATFORM_ENUM_(ConnectionState, CONNECTION_CONNECTED, CONNECTION_DISCONNECTED, CONNECTION_CONNECTING, CONNECTION_DISCONNECTING);

_MAKE_PLATFORM_ENUM_(CallType, OneOnOne, ConferenceCall);

_MAKE_PLATFORM_ENUM_(UserCallRequestType, InitCallControl, InviteCall, AnswerCall, HangupCall, CancelCall);

_MAKE_PLATFORM_ENUM_(CallState, Calling,  InCall, Canceled, Disconnected, Idle);

_MAKE_PLATFORM_ENUM_(CallRequestState, Unknown, Calling, AlreadyInCall, Accepted, Rejected, Busy, Canceled);

_MAKE_PLATFORM_ENUM_(ConferenceStateInCall, Unknown, Idle, Connecting, Joined, Disconnecting, Reconnecting);

_MAKE_PLATFORM_ENUM_(ParticipantType, VoIP, PSTN);

_MAKE_PLATFORM_ENUM_(ResolutionLevel, ResolutionLevelNotSpecified, ResolutionLevelLow, ResolutionLevelMed, ResolutionLevelHigh, ResolutionLevelHD);


struct ConnectionStatistics
{
	double  InboundPacketLoss;
	double  OutboundPacketLoss;
	unsigned long   InboundBandwidth;
	unsigned long   OutboundBandwidth;
};

enum class PstnCallState
{
    StartCall,
    EndCall,
    InProgress,
    Ringing,
    CalIsBeingForwarded,
    Queued,
    SessionInProgress,
    OK,
    BadRequest,
    PaymentRequired,
    NotFound,
    RequestTimedOut,
    ConnectionTimeOut,
    TooManyPstnClients,
    InvalidPhoneNumber,
    InfrastructureError
};


}
}

namespace oovoo {
namespace API {



////////////////////////////////////////////////////////////////////////////////////////////////////
/// \brief ooVoo SDK Conference States.
////////////////////////////////////////////////////////////////////////////////////////////////////

enum ConferenceState
{
	Joined,           //!< Local user joined to conference
	Disconnected      //!< Local user disconnect form conference , see error code for reason
};


enum LogLevel
{
	None = 0,
	Fatal = 1,
	Error = 2,
	Warning = 3,
	Info = 4,
	Debug = 5,
	Trace = 6
};

}
}; // namespace oovoo

#endif // _OOVOO_SDK_DEFS_
