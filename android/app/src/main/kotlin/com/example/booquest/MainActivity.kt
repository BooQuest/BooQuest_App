package com.example.booquest

import android.os.Bundle
import com.kakao.sdk.common.KakaoSdk
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Kakao SDK 초기화
        KakaoSdk.init(this, "635d855eae5acd47eaaaf28fc6b49ca8")
    }
}
