import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:booquest/features/auth/presentation/auth_wrapper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:booquest/features/auth/presentation/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase 초기화
  await Firebase.initializeApp();
  
  // Firebase Analytics 초기화
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  
  // Firebase Crashlytics 초기화
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  
  // Firebase Messaging 초기화
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  
  // 카카오 SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '635d855eae5acd47eaaaf28fc6b49ca8',
    javaScriptAppKey: '635d855eae5acd47eaaaf28fc6b49ca8',
  );
  
  // NetworkClient는 AuthWrapper에서 필요할 때 초기화됩니다
  
  // AdMob 초기화
  await MobileAds.instance.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BooQuest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const AuthWrapper(),
      },
    );
  }
}
