import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

//token.accessToken
//token.expiredAt
//token.expiresIn
//token.refreshToken
//token.refreshTokenExpiredAt
//token.refreshTokenExpiresIn
//token.scope
//token.scopes
//token.tokenType
@objc(ReactNativeKakaoLogin)
class ReactNativeKakaoLogin: NSObject {
    
    func parseOAuthToken(oauthToken: OAuthToken) -> [String: Any] {
        var oauthTokenInfos: [String: Any] = [
            "accessToken": oauthToken.accessToken,
            "expiredAt": oauthToken.expiredAt,
            "expiresIn": oauthToken.expiresIn,
            "refreshToken": oauthToken.refreshToken,
            "refreshTokenExpiredAt": oauthToken.refreshTokenExpiredAt,
            "refreshTokenExpiresIn": oauthToken.refreshTokenExpiresIn,
            "tokenType": oauthToken.tokenType
        ]
        if let scope = oauthToken.scope {
            oauthTokenInfos["scope"] = scope
        }
        if let scopes = oauthToken.scopes {
            oauthTokenInfos["scopes"] = scopes
        }
        return oauthTokenInfos
    }
    
    @objc
    func login(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        let isKakaoAppInstalled: Bool = AuthApi.isKakaoTalkLoginAvailable()
        if isKakaoAppInstalled {
            AuthApi.shared.loginWithKakaoTalk {(oauthToken: OAuthToken?, error: Error?) in
                if let error = error {
                    reject("KAKAO LOGIN ERROR", error.localizedDescription, error)
                    return
                }
                if let oauthToken = oauthToken {
                    let oauthTokenInfos = self.parseOAuthToken(oauthToken: oauthToken)
                    resolve(oauthTokenInfos)
                }
            }
        } else {
            AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    reject("KAKAO LOGIN ERROR", error.localizedDescription, error)
                    return
                }
                if let oauthToken = oauthToken {
                    let oauthTokenInfos = self.parseOAuthToken(oauthToken: oauthToken)
                    resolve(oauthTokenInfos)
                }
            }
        }
    }
    
    func parseUser(user: User) -> [String: Any] {
        var userInfo: [String: Any] = [
            "id": user.id
        ]
        if let connectedAt = user.connectedAt {
            userInfo["connectedAt"] = connectedAt
        }
        if let groupUserToken = user.groupUserToken {
            userInfo["groupUserToken"] = groupUserToken
        }
        if let kakaoAccount = user.kakaoAccount {
            userInfo["kakaoAccount"] = kakaoAccount
        }
        if let properties = user.properties {
            userInfo["properties"] = properties
        }
        if let synchedAt = user.synchedAt {
            userInfo["synchedAt"] = synchedAt
        }
        return userInfo
    }
    
    @objc
    func getProfile(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        UserApi.shared.me { (user: User?, error: Error?) in
            if let error = error {
                reject("KAKAO GET PROFILE ERROR", error.localizedDescription, error)
                return
            }
            if let user = user {
                let userInfo = self.parseUser(user: user)
                resolve(userInfo)
            }
        }
    }
    
    @objc
    func logout(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        UserApi.shared.logout { (error: Error?) in
            if let error = error {
                reject("KAKAO LOGOUT ERROR", error.localizedDescription, error)
                return
            }
            resolve(["success": true])
        }
    }
    
    @objc
    func unlink(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        UserApi.shared.unlink { (error: Error?) in
            if let error = error {
                reject("KAKAO UNLINK ERROR", error.localizedDescription, error)
                return
            }
            resolve(["sucess": true])
        }
    }
}
