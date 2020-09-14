package com.killi8nreactnativekakaologin

import android.content.ContentValues.TAG
import android.util.Log
import com.facebook.react.bridge.*
import com.kakao.sdk.auth.LoginClient
import com.kakao.sdk.user.UserApi
import com.kakao.sdk.user.UserApiClient

class ReactNativeKakaoLoginModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "ReactNativeKakaoLogin"
    }

    // Example method
    // See https://facebook.github.io/react-native/docs/native-modules-android
    @ReactMethod
    fun multiply(a: Int, b: Int, promise: Promise) {

      promise.resolve(a * b)

    }

    @ReactMethod
    fun login(promise: Promise) {
      var isKakaoAppInstalled: Boolean = LoginClient.instance.isKakaoTalkLoginAvailable(this.reactApplicationContext);
      if (isKakaoAppInstalled) {
        // 카카오톡으로 로그인
        LoginClient.instance.loginWithKakaoTalk(this.reactApplicationContext) { token, error ->
          if (error != null) {
            promise.reject("KAKAO LOGIN ERROR", error);
            Log.e(TAG, "로그인 실패", error)
          } else if (token != null) {
            var tokenInfos = Arguments.createMap();
            tokenInfos.putString("accessToken", token.accessToken);
            tokenInfos.putString("expiredAt", token.accessTokenExpiresAt.toString());
            tokenInfos.putString("refreshToken", token.refreshToken);
            token.refreshTokenExpiresAt?.let {
              tokenInfos.putString("refreshTokenExpiresAt", it.toString());
            }
            promise.resolve(tokenInfos);
            Log.i(TAG, "로그인 성공 ${token.accessToken}")
          }
        }
      } else {
        // 카카오계정으로 로그인
        LoginClient.instance.loginWithKakaoAccount(this.reactApplicationContext) { token, error ->
          if (error != null) {
            promise.reject("KAKAO LOGIN ERROR", error);
            Log.e(TAG, "로그인 실패", error)
          } else if (token != null) {
            var tokenInfos = Arguments.createMap();
            tokenInfos.putString("accessToken", token.accessToken);
            tokenInfos.putString("expiredAt", token.accessTokenExpiresAt.toString());
            tokenInfos.putString("refreshToken", token.refreshToken);
            token.refreshTokenExpiresAt?.let {
              tokenInfos.putString("refreshTokenExpiresAt", it.toString());
            }
            promise.resolve(tokenInfos);
            Log.i(TAG, "로그인 성공 ${token.accessToken}")
          }
        }
      }
    }

    @ReactMethod
    fun getProfile(promise: Promise) {
      UserApiClient.instance.me { user, error ->
        if (error != null) {
          promise.reject("KAKAO GET PROFILE ERROR", error);
        } else if (user != null) {
          var userInfos = Arguments.createMap();
          userInfos.putInt("id", user.id.toInt());
          var propertyInfos = Arguments.createMap()
          user.properties?.let { it
            if (it.getValue("nickname") != null) {
              propertyInfos.putString("nickname", it.getValue("nickname"));
            }
            if (it.getValue("profile_image") != null) {
              propertyInfos.putString("profile_image", it.getValue("profile_image"));
            }
            if (it.getValue("thumbnail_image") != null) {
              propertyInfos.putString("thumbnail_image", it.getValue("thumbnail_image"));
            }
          }
          userInfos.putMap("properties", propertyInfos);
          promise.resolve(userInfos);
        }
      }
    }

    @ReactMethod
    fun logout(promise: Promise) {
      UserApiClient.instance.logout { error ->
        if (error != null) {
          promise.reject("KAKAO LOGOUT ERROR", error);
        } else {
          var result = Arguments.createMap();
          result.putBoolean("success", true);
          promise.resolve(result);
        }
      }
    }

    @ReactMethod
    fun unlink(promise: Promise) {
      UserApiClient.instance.unlink { error ->
        if (error != null) {
          promise.reject("KAKAO UNLINK ERROR", error);
        } else {
          var result = Arguments.createMap();
          result.putBoolean("success", true);
          promise.resolve(result);
        }
      }
    }
}
