# 보안 설정 가이드

## 카카오 앱 키 설정

### 1. 환경변수 방식 (권장)

**빌드 시 환경변수 주입:**
```bash
# Android 빌드
flutter build apk --dart-define=KAKAO_ANDROID_APP_KEY=your_actual_android_key

# iOS 빌드  
flutter build ios --dart-define=KAKAO_IOS_APP_KEY=your_actual_ios_key

# 개발 모드
flutter run --dart-define=KAKAO_ANDROID_APP_KEY=your_actual_android_key
```

### 2. 별도 설정 파일 방식 (개발용)

**`lib/config/app_secrets.dart` 파일 생성:**
```dart
class AppSecrets {
  static const String androidKakaoKey = 'your_actual_android_key';
  static const String iosKakaoKey = 'your_actual_ios_key';
}
```

**`constants.dart`에서 사용:**
```dart
import '../config/app_secrets.dart';

static String get kakaoAppKey {
  if (Platform.isAndroid) {
    return AppSecrets.androidKakaoKey;
  } else if (Platform.isIOS) {
    return AppSecrets.iosKakaoKey;
  }
  throw UnsupportedError('지원하지 않는 플랫폼입니다.');
}
```

## 주의사항

1. **절대 Git에 앱 키를 올리지 마세요**
2. **`app_secrets.dart`는 `.gitignore`에 포함되어 있습니다**
3. **팀원들과 앱 키를 공유할 때는 안전한 방법을 사용하세요**
4. **프로덕션 빌드는 반드시 환경변수 방식으로 진행하세요**

## 카카오 개발자 콘솔 설정

1. [Kakao Developers](https://developers.kakao.com) 접속
2. 앱 생성 및 플랫폼 등록
3. Android/iOS 앱 키 발급
4. 각 플랫폼별 설정 완료 