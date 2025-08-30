import 'package:shared_preferences/shared_preferences.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';

/// Core 계층: 앱 전반의 설정 및 상태 관리 로컬 스토리지 서비스
/// 
/// 앱의 전반적인 설정과 상태 정보를 관리합니다.
/// 온보딩 완료 여부, 앱 설정 등 앱 수준의 데이터를 담당합니다.
class LocalStorageService {
  // 앱 상태 키
  static const String _appVersionKey = 'app_version';
  static const String _firstLaunchKey = 'app_first_launch';
  
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  
  LocalStorageService._();
  
  /// 싱글톤 인스턴스 획득
  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  /// 동기 인스턴스 획득 (이미 초기화된 경우에만 사용)
  static LocalStorageService getInstanceSync() {
    if (_instance == null || _preferences == null) {
      throw Exception('LocalStorageService가 초기화되지 않았습니다. getInstance()를 먼저 호출하세요.');
    }
    return _instance!;
  }



  // ========== 앱 설정 관리 ==========

  /// 앱 버전 저장
  Future<void> setAppVersion(String version) async {
    await _preferences?.setString(_appVersionKey, version);
  }

  /// 앱 버전 조회
  String? getAppVersion() {
    return _preferences?.getString(_appVersionKey);
  }

  /// 첫 실행 여부 저장
  Future<void> setFirstLaunch(bool isFirst) async {
    await _preferences?.setBool(_firstLaunchKey, isFirst);
  }

  /// 첫 실행 여부 확인
  bool isFirstLaunch() {
    return _preferences?.getBool(_firstLaunchKey) ?? true;
  }

  // ========== 데이터 관리 ==========

  /// 앱 설정 데이터 초기화
  Future<void> clearAppSettings() async {
    await _preferences?.remove(_appVersionKey);
    await _preferences?.remove(_firstLaunchKey);
  }

  /// 토큰을 제외한 모든 로컬 데이터 초기화 (부업 생성 완료 시 사용)
  Future<void> clearAllDataExceptToken() async {
    if (_preferences != null) {
      // 모든 키 가져오기
      final keys = _preferences!.getKeys();
      
      // 토큰 관련 키는 제외하고 모든 데이터 삭제
      for (final key in keys) {
        if (!key.contains('token') && !key.contains('auth')) {
          await _preferences!.remove(key);
        }
      }
      print('🧹 토큰을 제외한 모든 로컬 데이터 초기화 완료');
    }
  }

  /// 디버깅용: 현재 저장된 앱 설정 데이터 출력
  void printAppSettings() {
    print('--- LocalStorageService Data ---');

    print('App Version: ${getAppVersion()}');
    print('First Launch: ${isFirstLaunch()}');
    print('------------------------------');
  }

  // ========== 레거시 호환성 메서드 (기존 코드와의 호환을 위해 임시 유지) ==========
  // TODO: 온보딩 관련 코드를 OnboardingStorageService로 완전 이관 후 삭제

  /// @deprecated OnboardingStorageService.getCurrentStep() 사용
  int getCurrentOnboardingStep() {
    // 임시로 OnboardingStorageService에서 가져오기
    try {
      final onboardingService = OnboardingStorageService.getInstanceSync();
      return onboardingService.getCurrentStep();
    } catch (e) {
      return 0;
    }
  }

  /// @deprecated OnboardingStorageService.getCharacterScreenType() 사용
  String? getCharacterScreenType() {
    try {
      final onboardingService = OnboardingStorageService.getInstanceSync();
      return onboardingService.getCharacterScreenType();
    } catch (e) {
      return null;
    }
  }
}
