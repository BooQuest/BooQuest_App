package com.booquest.app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // 카카오 SDK는 Flutter에서 초기화됨
        // 네이버 SDK는 flutter_naver_login 패키지에서 자동으로 초기화됨
    }
}
