import 'package:shared_preferences/shared_preferences.dart';

/// Infrastructure 계층: 온보딩 관련 로컬 스토리지 서비스
/// 
/// 온보딩 과정에서 수집되는 사용자 데이터를 로컬에 저장 관리합니다.
/// 캐릭터 정보, 직업, 취미, 선호도 등 온보딩 전용 데이터를 담당합니다.
class OnboardingStorageService {
  // 온보딩 데이터 키
  static const String _characterNameKey = 'onboarding_character_name';
  static const String _characterTypeKey = 'onboarding_character_type';
  static const String _characterScreenTypeKey = 'onboarding_character_screen_type';
  static const String _jobKey = 'onboarding_job';
  static const String _hobbiesKey = 'onboarding_hobbies';
  static const String _expressionStyleKey = 'onboarding_expression_style';
  static const String _strengthTypeKey = 'onboarding_strength_type';
  static const String _currentStepKey = 'onboarding_current_step';

  static OnboardingStorageService? _instance;
  static SharedPreferences? _preferences;

  OnboardingStorageService._();

  /// 싱글톤 인스턴스 획득
  static Future<OnboardingStorageService> getInstance() async {
    if (_instance == null) {
      _instance = OnboardingStorageService._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  /// 동기 인스턴스 획득 (이미 초기화된 경우에만 사용)
  static OnboardingStorageService getInstanceSync() {
    if (_instance == null || _preferences == null) {
      throw Exception('OnboardingStorageService가 초기화되지 않았습니다. getInstance()를 먼저 호출하세요.');
    }
    return _instance!;
  }

  // ========== 캐릭터 관련 ==========

  /// 캐릭터 이름 저장
  Future<void> setCharacterName(String name) async {
    await _preferences?.setString(_characterNameKey, name);
  }

  /// 캐릭터 이름 조회
  String? getCharacterName() {
    return _preferences?.getString(_characterNameKey);
  }

  /// 캐릭터 타입 저장 (BLACK/WHITE)
  Future<void> setCharacterType(String type) async {
    await _preferences?.setString(_characterTypeKey, type);
  }

  /// 캐릭터 타입 조회
  String? getCharacterType() {
    return _preferences?.getString(_characterTypeKey);
  }

  /// 캐릭터 화면 타입 저장 (selection/creation)
  Future<void> setCharacterScreenType(String screenType) async {
    await _preferences?.setString(_characterScreenTypeKey, screenType);
  }

  /// 캐릭터 화면 타입 조회
  String? getCharacterScreenType() {
    return _preferences?.getString(_characterScreenTypeKey);
  }

  // ========== 직업/취미 관련 ==========

  /// 직업 저장
  Future<void> setJob(String job) async {
    await _preferences?.setString(_jobKey, job);
  }

  /// 직업 조회
  String? getJob() {
    return _preferences?.getString(_jobKey);
  }

  /// 취미 목록 저장
  Future<void> setHobbies(List<String> hobbies) async {
    await _preferences?.setStringList(_hobbiesKey, hobbies);
  }

  /// 취미 목록 조회
  List<String> getHobbies() {
    return _preferences?.getStringList(_hobbiesKey) ?? <String>[];
  }

  // ========== 선호도 관련 ==========

  /// 표현 방식 저장
  Future<void> setExpressionStyle(String style) async {
    await _preferences?.setString(_expressionStyleKey, style);
  }

  /// 표현 방식 조회
  String? getExpressionStyle() {
    return _preferences?.getString(_expressionStyleKey);
  }

  /// 자신 있는 방식 타입 저장
  Future<void> setStrengthType(String strengthType) async {
    await _preferences?.setString(_strengthTypeKey, strengthType);
  }

  /// 자신 있는 방식 타입 조회
  String? getStrengthType() {
    return _preferences?.getString(_strengthTypeKey);
  }

  // ========== 진행 상태 관리 ==========

  /// 현재 온보딩 단계 저장
  Future<void> setCurrentStep(int step) async {
    await _preferences?.setInt(_currentStepKey, step);
  }

  /// 현재 온보딩 단계 조회
  int getCurrentStep() {
    return _preferences?.getInt(_currentStepKey) ?? 0;
  }

  /// 현재 온보딩 단계 삭제
  Future<void> removeCurrentStep() async {
    await _preferences?.remove(_currentStepKey);
  }

  // ========== 데이터 관리 ==========

  /// 모든 온보딩 데이터 삭제
  Future<void> clearAllData() async {
    await _preferences?.remove(_characterNameKey);
    await _preferences?.remove(_characterTypeKey);
    await _preferences?.remove(_characterScreenTypeKey);
    await _preferences?.remove(_jobKey);
    await _preferences?.remove(_hobbiesKey);
    await _preferences?.remove(_expressionStyleKey);
    await _preferences?.remove(_strengthTypeKey);
    await _preferences?.remove(_currentStepKey);
  }

  /// 디버깅용: 현재 저장된 온보딩 데이터 출력
  void printOnboardingData() {
    print('--- OnboardingStorageService Data ---');
    print('Character Name: ${getCharacterName()}');
    print('Character Type: ${getCharacterType()}');
    print('Character Screen Type: ${getCharacterScreenType()}');
    print('Job: ${getJob()}');
    print('Hobbies: ${getHobbies()}');
    print('Expression Style: ${getExpressionStyle()}');
    print('Strength Type: ${getStrengthType()}');
    print('Current Step: ${getCurrentStep()}');
    print('-----------------------------------');
  }
}
