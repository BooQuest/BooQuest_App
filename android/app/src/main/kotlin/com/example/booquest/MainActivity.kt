package com.example.booquest

import android.os.Bundle
import com.kakao.sdk.common.KakaoSdk
import com.nhn.android.naverlogin.OAuthLogin
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Kakao SDK 초기화
        KakaoSdk.init(this, "635d855eae5acd47eaaaf28fc6b49ca8")
        
        // 네이버 SDK 초기화
        OAuthLogin.getInstance().init(
            this,
            "TM5eDkpd_rKv82eBNyJd", // Client ID
            "unToCI8V3H", // Client Secret
            "Booquest" // App Name
        )
    }
}
