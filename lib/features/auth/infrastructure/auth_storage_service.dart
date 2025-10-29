import 'package:shared_preferences/shared_preferences.dart';

/// Infrastructure 계층: 인증 관련 로컬 스토리지 서비스
/// 
/// 인증 관련 데이터의 로컬 저장소 관리를 담당합니다.
/// SharedPreferences를 사용하여 토큰, 사용자 정보 등을 안전하게 저장합니다.
class AuthStorageService {
  static const String _userIdKey = 'auth_user_id';
  static const String _emailKey = 'auth_email';
  static const String _nicknameKey = 'auth_nickname';
  static const String _socialNicknameKey = 'auth_social_nickname';
  static const String _profileImageUrlKey = 'auth_profile_image_url';
  static const String _sideJobIdKey = 'auth_side_job_id';
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _providerAccessTokenKey = 'auth_provider_access_token';
  static const String _providerKey = 'auth_provider';
  static const String _characterTypeKey = 'auth_character_type';
  static const String _isAuthenticatedKey = 'auth_is_authenticated';
  static const String _tokenExpiresAtKey = 'auth_token_expires_at';

  static AuthStorageService? _instance;
  static SharedPreferences? _preferences;

  AuthStorageService._();

  /// 싱글톤 인스턴스 획득
  static Future<AuthStorageService> getInstance() async {
    if (_instance == null) {
      _instance = AuthStorageService._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  /// 싱글톤 인스턴스 획득 (동기 버전)
  /// 주의: SharedPreferences가 이미 초기화된 경우에만 사용
  static AuthStorageService getInstanceSync() {
    if (_instance == null) {
      throw Exception('AuthStorageService not initialized. Call getInstance() first.');
    }
    return _instance!;
  }

  // ========== 사용자 정보 관련 ==========

  /// 사용자 ID 저장
  Future<void> setUserId(int userId) async {
    await _preferences?.setInt(_userIdKey, userId);
  }

  /// 사용자 ID 조회
  int? getUserId() {
    return _preferences?.getInt(_userIdKey);
  }

  /// 사용자 ID 삭제
  Future<void> removeUserId() async {
    await _preferences?.remove(_userIdKey);
  }

  /// 이메일 저장
  Future<void> setEmail(String email) async {
    await _preferences?.setString(_emailKey, email);
  }

  /// 이메일 조회
  String? getEmail() {
    return _preferences?.getString(_emailKey);
  }

  /// 닉네임 저장
  Future<void> setNickname(String nickname) async {
    await _preferences?.setString(_nicknameKey, nickname);
  }

  /// 닉네임 조회
  String? getNickname() {
    return _preferences?.getString(_nicknameKey);
  }

  /// 소셜 닉네임 저장
  Future<void> setSocialNickname(String socialNickname) async {
    await _preferences?.setString(_socialNicknameKey, socialNickname);
  }

  /// 소셜 닉네임 조회
  String? getSocialNickname() {
    return _preferences?.getString(_socialNicknameKey);
  }

  /// 프로필 이미지 URL 저장
  Future<void> setProfileImageUrl(String url) async {
    await _preferences?.setString(_profileImageUrlKey, url);
  }

  /// 프로필 이미지 URL 조회
  String? getProfileImageUrl() {
    return _preferences?.getString(_profileImageUrlKey);
  }

  /// SideJob ID 저장
  Future<void> setSideJobId(int sideJobId) async {
    await _preferences?.setInt(_sideJobIdKey, sideJobId);
  }

  /// SideJob ID 조회
  int? getSideJobId() {
    return _preferences?.getInt(_sideJobIdKey);
  }

  /// SideJob ID 삭제
  Future<void> removeSideJobId() async {
    await _preferences?.remove(_sideJobIdKey);
  }

  // ========== 토큰 관련 ==========

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

  /// Provider Access Token 저장
  Future<void> setProviderAccessToken(String token) async {
    await _preferences?.setString(_providerAccessTokenKey, token);
  }

  /// Provider Access Token 조회
  String? getProviderAccessToken() {
    return _preferences?.getString(_providerAccessTokenKey);
  }

  /// Provider 저장
  Future<void> setProvider(String provider) async {
    await _preferences?.setString(_providerKey, provider);
  }

  /// Provider 조회
  String? getProvider() {
    return _preferences?.getString(_providerKey);
  }

  /// Character Type 저장
  Future<void> setCharacterType(String characterType) async {
    await _preferences?.setString(_characterTypeKey, characterType);
  }

  /// Character Type 조회
  String? getCharacterType() {
    return _preferences?.getString(_characterTypeKey);
  }

  /// Token 만료 시간 저장 (Unix timestamp)
  Future<void> setTokenExpiresAt(int timestamp) async {
    await _preferences?.setInt(_tokenExpiresAtKey, timestamp);
  }

  /// Token 만료 시간 조회 (Unix timestamp)
  int? getTokenExpiresAt() {
    return _preferences?.getInt(_tokenExpiresAtKey);
  }

  // ========== 인증 상태 관련 ==========

  /// 인증 상태 저장
  Future<void> setIsAuthenticated(bool isAuthenticated) async {
    await _preferences?.setBool(_isAuthenticatedKey, isAuthenticated);
  }

  /// 인증 상태 조회
  bool getIsAuthenticated() {
    return _preferences?.getBool(_isAuthenticatedKey) ?? false;
  }

  // ========== 사용자 정보 통합 관리 ==========

  /// 사용자 정보 저장 
  Future<void> saveUserInfo({
    required int userId,
    required String email,
    required String nickname,
    String? socialNickname,
    String? profileImageUrl,
    int? sideJobId,
    String? characterType,
  }) async {
    await _preferences?.setInt(_userIdKey, userId);
    await _preferences?.setString(_emailKey, email);
    await _preferences?.setString(_nicknameKey, nickname);
    
    if (socialNickname != null) {
      await _preferences?.setString(_socialNicknameKey, socialNickname);
    }
    
    if (profileImageUrl != null) {
      await _preferences?.setString(_profileImageUrlKey, profileImageUrl);
    }
    
    if (sideJobId != null) {
      await _preferences?.setInt(_sideJobIdKey, sideJobId);
    }
    
    if (characterType != null) {
      await _preferences?.setString(_characterTypeKey, characterType);
    }
  }

  /// 사용자 정보 일괄 조회
  Map<String, dynamic>? getUserInfo() {
    final userId = getUserId();
    final email = getEmail();
    
    if (userId == null || email == null) return null;

    return {
      'userId': userId,
      'email': email,
      'nickname': getNickname(),
      'socialNickname': getSocialNickname(),
      'profileImageUrl': getProfileImageUrl(),
      'sideJobId': getSideJobId(),
      'characterType': getCharacterType(),
    };
  }

  /// 토큰 정보 일괄 저장
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    int? expiresIn, // 초 단위
  }) async {
    await setAccessToken(accessToken);
    await setRefreshToken(refreshToken);
    await setIsAuthenticated(true);
    
    // expires 값이 있으면 현재 시간 + expiresIn으로 만료시간 계산
    if (expiresIn != null) {
      final expiresAt = DateTime.now().millisecondsSinceEpoch ~/ 1000 + expiresIn;
      await setTokenExpiresAt(expiresAt);
    }
  }

  /// 소셜 로그인 정보 저장
  Future<void> saveSocialLoginInfo({
    required String providerAccessToken,
    required String provider,
  }) async {
    await setProviderAccessToken(providerAccessToken);
    await setProvider(provider);
  }

  /// 토큰 정보 조회
  Map<String, String?> getTokens() {
    return {
      'accessToken': getAccessToken(),
      'refreshToken': getRefreshToken(),
    };
  }

  // ========== 데이터 초기화 ==========

  /// 모든 인증 관련 데이터 삭제 (로그아웃 시)
  Future<void> clearAuthData() async {
    await _preferences?.remove(_userIdKey);
    await _preferences?.remove(_emailKey);
    await _preferences?.remove(_nicknameKey);
    await _preferences?.remove(_socialNicknameKey);
    await _preferences?.remove(_profileImageUrlKey);
    await _preferences?.remove(_sideJobIdKey);
    await _preferences?.remove(_accessTokenKey);
    await _preferences?.remove(_refreshTokenKey);
    await _preferences?.remove(_providerAccessTokenKey);
    await _preferences?.remove(_providerKey);
    await _preferences?.remove(_characterTypeKey);
    await _preferences?.remove(_isAuthenticatedKey);
    await _preferences?.remove(_tokenExpiresAtKey);
  }

  /// 토큰만 삭제 (토큰 만료 시)
  Future<void> clearTokens() async {
    await _preferences?.remove(_accessTokenKey);
    await _preferences?.remove(_refreshTokenKey);
    await _preferences?.remove(_providerAccessTokenKey);
    await _preferences?.remove(_providerKey);
    await _preferences?.remove(_characterTypeKey);
    await _preferences?.remove(_tokenExpiresAtKey);
    await setIsAuthenticated(false);
  }

  // ========== 유틸리티 ==========

  /// 인증 데이터 존재 여부 확인
  bool hasAuthData() {
    return getUserId() != null && 
           getEmail() != null && 
           getAccessToken() != null;
  }

  /// 디버그용: 모든 인증 데이터 출력
  void printAuthData() {
    print('=== Auth Storage Data ===');
    print('UserId: ${getUserId()}');
    print('Email: ${getEmail()}');
    print('Nickname: ${getNickname()}');
    print('SocialNickname: ${getSocialNickname()}');
    print('ProfileImageUrl: ${getProfileImageUrl()}');
    print('CharacterType: ${getCharacterType()}');
    print('AccessToken: ${getAccessToken()?.substring(0, 20)}...');
    print('RefreshToken: ${getRefreshToken()?.substring(0, 20)}...');
    print('ProviderAccessToken: ${getProviderAccessToken()?.substring(0, 20)}...');
    print('Provider: ${getProvider()}');
    print('IsAuthenticated: ${getIsAuthenticated()}');
    print('========================');
  }
}
