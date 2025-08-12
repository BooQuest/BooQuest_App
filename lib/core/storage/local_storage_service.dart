import 'package:shared_preferences/shared_preferences.dart';

/// 로컬 스토리지 서비스
/// SharedPreferences를 사용하여 앱 데이터를 로컬에 저장
class LocalStorageService {
  static const String _characterNameKey = 'character_name';
  static const String _jobKey = 'job';
  static const String _hobbiesKey = 'hobbies';
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _onboardingStageKey = 'onboarding_stage'; // 0: character, 1: job, 2: hobby, 3: coaching
  static const String _jobScreenStateKey = 'job_screen_state'; // 0: 기본 선택, 1: 입력 폼
  static const String _coachingScreenStateKey = 'coaching_screen_state'; // 0: 기본 선택, 1: 입력 폼
  static const String _coachingSideJobKey = 'coaching_side_job'; // 코칭 부업 입력값
  
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
    success &= await _preferences?.remove(_jobKey) ?? false;
    success &= await _preferences?.remove(_hobbiesKey) ?? false;
    success &= await _preferences?.remove(_onboardingCompletedKey) ?? false;
    success &= await _preferences?.remove(_onboardingStageKey) ?? false;
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
}
