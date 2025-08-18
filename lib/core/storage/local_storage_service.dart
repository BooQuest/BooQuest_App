import 'package:shared_preferences/shared_preferences.dart';

/// 로컬 스토리지 서비스
/// SharedPreferences를 사용하여 앱 데이터를 로컬에 저장
class LocalStorageService {
  // 로컬 저장소 키
  static const String _characterNameKey = 'character_name';
  static const String _characterTypeKey = 'character_type';
  static const String _characterScreenTypeKey = 'character_screen_type';
  static const String _jobKey = 'job';
  static const String _hobbiesKey = 'hobbies';
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _onboardingStageKey = 'onboarding_stage'; // 0: character, 1: job, 2: hobby, 3: coaching
  static const String _jobScreenStateKey = 'job_screen_state'; // 0: 기본 선택, 1: 입력 폼
  static const String _coachingScreenStateKey = 'coaching_screen_state'; // 0: 기본 선택, 1: 입력 폼
  static const String _coachingSideJobKey = 'coaching_side_job'; // 코칭 부업 입력값
  static const String _userIdKey = 'user_id';
  static const String _emailKey = 'email';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _profileImageUrlKey = 'profile_image_url';
  static const String _expressionStyleKey = 'expression_style';
  
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  
  LocalStorageService._();
  
  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }
  
  /// 캐릭터 이름 저장
  Future<bool> saveCharacterName(String name) async {
    return await _preferences?.setString(_characterNameKey, name) ?? false;
  }
  
  /// 캐릭터 이름 불러오기
  String? getCharacterName() {
    return _preferences?.getString(_characterNameKey);
  }

  /// 캐릭터 타입 저장
  Future<bool> saveCharacterType(String type) async {
    return await _preferences?.setString(_characterTypeKey, type) ?? false;
  }
  
  /// 캐릭터 타입 불러오기
  String? getCharacterType() {
    return _preferences?.getString(_characterTypeKey);
  }

  /// 캐릭터 화면 타입 저장 (selection 또는 creation)
  Future<bool> saveCharacterScreenType(String screenType) async {
    return await _preferences?.setString(_characterScreenTypeKey, screenType) ?? false;
  }
  
  /// 캐릭터 화면 타입 불러오기
  String? getCharacterScreenType() {
    return _preferences?.getString(_characterScreenTypeKey);
  }

  /// 직업 저장
  Future<bool> saveJob(String job) async {
    return await _preferences?.setString(_jobKey, job) ?? false;
  }

  /// 직업 불러오기
  String? getJob() {
    return _preferences?.getString(_jobKey);
  }

  /// 취미 목록 저장
  Future<bool> saveHobbies(List<String> hobbies) async {
    return await _preferences?.setStringList(_hobbiesKey, hobbies) ?? false;
  }

  /// 취미 목록 불러오기
  List<String> getHobbies() {
    return _preferences?.getStringList(_hobbiesKey) ?? <String>[];
  }
  
  /// 온보딩 완료 상태 저장
  Future<bool> setOnboardingCompleted(bool completed) async {
    return await _preferences?.setBool(_onboardingCompletedKey, completed) ?? false;
  }

  /// 온보딩 완료 상태 저장 (새로운 메서드)
  Future<void> setIsOnboardingCompleted(bool completed) async {
    await _preferences?.setBool(_onboardingCompletedKey, completed);
  }
  
  /// 온보딩 완료 상태 확인
  bool isOnboardingCompleted() {
    return _preferences?.getBool(_onboardingCompletedKey) ?? false;
  }

  /// 온보딩 현재 스테이지 저장 (0~3)
  Future<bool> setOnboardingStage(int stage) async {
    return await _preferences?.setInt(_onboardingStageKey, stage) ?? false;
  }

  /// 온보딩 현재 스테이지 조회
  int? getOnboardingStage() {
    return _preferences?.getInt(_onboardingStageKey);
  }

  /// 온보딩 스테이지 삭제
  Future<bool> removeOnboardingStage() async {
    return await _preferences?.remove(_onboardingStageKey) ?? false;
  }

  /// 온보딩 상세 데이터만 삭제 (완료 플래그는 유지)
  Future<bool> clearOnboardingDetailsOnly() async {
    bool success = true;
    success &= await _preferences?.remove(_characterNameKey) ?? false;
    success &= await _preferences?.remove(_characterTypeKey) ?? false;
    success &= await _preferences?.remove(_characterScreenTypeKey) ?? false;
    success &= await _preferences?.remove(_jobKey) ?? false;
    success &= await _preferences?.remove(_hobbiesKey) ?? false;
    success &= await _preferences?.remove(_onboardingStageKey) ?? false;
    success &= await _preferences?.remove(_jobScreenStateKey) ?? false;
    success &= await _preferences?.remove(_coachingScreenStateKey) ?? false;
    success &= await _preferences?.remove(_coachingSideJobKey) ?? false;
    return success;
  }
  
  /// 캐릭터 이름 삭제
  Future<bool> removeCharacterName() async {
    return await _preferences?.remove(_characterNameKey) ?? false;
  }

  /// 캐릭터 타입 삭제
  Future<bool> removeCharacterType() async {
    return await _preferences?.remove(_characterTypeKey) ?? false;
  }

  /// 캐릭터 화면 타입 삭제
  Future<bool> removeCharacterScreenType() async {
    return await _preferences?.remove(_characterScreenTypeKey) ?? false;
  }

  /// 직업 삭제
  Future<bool> removeJob() async {
    return await _preferences?.remove(_jobKey) ?? false;
  }

  /// 취미 삭제
  Future<bool> removeHobbies() async {
    return await _preferences?.remove(_hobbiesKey) ?? false;
  }
  
  /// 모든 온보딩 데이터 삭제
  Future<bool> clearOnboardingData() async {
    bool success = true;
    success &= await _preferences?.remove(_characterNameKey) ?? false;
    success &= await _preferences?.remove(_characterTypeKey) ?? false;
    success &= await _preferences?.remove(_jobKey) ?? false;
    success &= await _preferences?.remove(_hobbiesKey) ?? false;
    success &= await _preferences?.remove(_onboardingCompletedKey) ?? false;
    success &= await _preferences?.remove(_onboardingStageKey) ?? false;
    success &= await _preferences?.remove(_characterScreenTypeKey) ?? false;
    return success;
  }

  /// Job Screen State (0: 기본 선택, 1: 입력 폼)
  Future<bool> setJobScreenState(int state) async {
    return await _preferences?.setInt(_jobScreenStateKey, state) ?? false;
  }

  /// Job Screen State 조회
  int getJobScreenState() {
    return _preferences?.getInt(_jobScreenStateKey) ?? 0;
  }

  /// Job Screen State 삭제
  Future<bool> removeJobScreenState() async {
    return await _preferences?.remove(_jobScreenStateKey) ?? false;
  }

  /// Coaching Screen State (0: 기본 선택, 1: 입력 폼)
  Future<bool> setCoachingScreenState(int state) async {
    return await _preferences?.setInt(_coachingScreenStateKey, state) ?? false;
  }

  int getCoachingScreenState() {
    return _preferences?.getInt(_coachingScreenStateKey) ?? 0;
  }

  Future<bool> removeCoachingScreenState() async {
    return await _preferences?.remove(_coachingScreenStateKey) ?? false;
  }

  /// Coaching Side Job 입력값 저장/조회/삭제
  Future<bool> saveCoachingSideJob(String value) async {
    return await _preferences?.setString(_coachingSideJobKey, value) ?? false;
  }

  String? getCoachingSideJob() {
    return _preferences?.getString(_coachingSideJobKey);
  }

  Future<bool> removeCoachingSideJob() async {
    return await _preferences?.remove(_coachingSideJobKey) ?? false;
  }

  /// 사용자 ID 저장
  Future<void> setUserId(int userId) async {
    await _preferences?.setInt(_userIdKey, userId);
  }

  /// 사용자 ID 조회
  int? getUserId() {
    return _preferences?.getInt(_userIdKey);
  }

  /// 이메일 저장
  Future<void> setEmail(String email) async {
    await _preferences?.setString(_emailKey, email);
  }

  /// 이메일 조회
  String? getEmail() {
    return _preferences?.getString(_emailKey);
  }

  /// Access Token 저장
  Future<void> setAccessToken(String token) async {
    await _preferences?.setString(_accessTokenKey, token);
  }

  /// Access Token 조회
  String? getAccessToken() {
    return _preferences?.getString(_accessTokenKey);
  }

  /// Refresh Token 저장
  Future<void> setRefreshToken(String token) async {
    await _preferences?.setString(_refreshTokenKey, token);
  }

  /// Refresh Token 조회
  String? getRefreshToken() {
    return _preferences?.getString(_refreshTokenKey);
  }

  /// 프로필 이미지 URL 저장
  Future<void> setProfileImageUrl(String url) async {
    await _preferences?.setString(_profileImageUrlKey, url);
  }

  /// 프로필 이미지 URL 조회
  String? getProfileImageUrl() {
    return _preferences?.getString(_profileImageUrlKey);
  }

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
    await _preferences?.setString('strength_type', strengthType);
  }
  
  /// 자신 있는 방식 타입 조회
  String? getStrengthType() {
    return _preferences?.getString('strength_type');
  }

  /// 현재 온보딩 단계 저장
  Future<bool> setCurrentOnboardingStep(int step) async {
    return await _preferences?.setInt('current_onboarding_step', step) ?? false;
  }
  
  /// 현재 온보딩 단계 조회
  int getCurrentOnboardingStep() {
    return _preferences?.getInt('current_onboarding_step') ?? 0;
  }
  
  /// 현재 온보딩 단계 삭제
  Future<bool> removeCurrentOnboardingStep() async {
    return await _preferences?.remove('current_onboarding_step') ?? false;
  }
}
