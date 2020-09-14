//
//  KakaoLoginUtils.swift
//  ReactNativeKakaoLoginExample
//
//  Created by Dongho Choi on 2020/09/14.
//  Copyright © 2020 Facebook. All rights reserved.
//

import KakaoSDKCommon
import KakaoSDKAuth

@objc
class KakaoLoginUtils: NSObject {
  
  @objc
  static func initSDK(appKey: String) -> Void {
    KakaoSDKCommon.initSDK(appKey: appKey)
  }
  
  @objc
  static func handleOpenUrl(url: URL) -> Bool {
    if (AuthApi.isKakaoTalkLoginUrl(url)) {
        return AuthController.handleOpenUrl(url: url)
    }

    return false
  }
}
