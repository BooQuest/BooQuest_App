import Flutter
import UIKit
import NidThirdPartyLogin
import KakaoSDKCommon

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // 카카오 SDK 초기화
    KakaoSDK.initSDK(appKey: "635d855eae5acd47eaaaf28fc6b49ca8")
    
    // 네이버 SDK 초기화
    NidOAuth.shared.configure(
      clientId: "TM5eDkpd_rKv82eBNyJd",
      clientSecret: "unToCI8V3H",
      appName: "Booquest"
    )
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // 네이버 로그인 콜백 URL 처리
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    if NidOAuth.shared.handleURL(url) == true {
      return true
    }
    return super.application(app, open: url, options: options)
  }
}
