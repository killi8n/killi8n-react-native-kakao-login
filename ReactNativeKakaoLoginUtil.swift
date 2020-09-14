//
//  ReactNativeKakaoLoginUtil.swift
//  Alamofire
//
//  Created by Dongho Choi on 2020/09/14.
//

import Foundation

@objc
class ReactNativeKakaoLoginUtil: NSObject {
    @objc
    static func handleOpenUrl(url: URL) -> Bool {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
}

