import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:booquest/features/auth/presentation/auth_wrapper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  
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
      home: const AuthWrapper(),
    );
  }
}
