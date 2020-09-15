#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ReactNativeKakaoLogin, NSObject)

RCT_EXTERN_METHOD(login: (RCTPromiseResolveBlock)resolve rejecter: (RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(getProfile: (RCTPromiseResolveBlock)resolve rejecter: (RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(logout: (RCTPromiseResolveBlock)resolve rejecter: (RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(unlink: (RCTPromiseResolveBlock)resolve rejecter: (RCTPromiseRejectBlock)reject)

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup {
    return true;
}

@end
