import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';

/// 사용자 데이터를 가져오는 공통 유틸리티 클래스
class UserDataUtils {
  static UserDataUtils? _instance;
  static UserDataUtils get instance => _instance ??= UserDataUtils._();
  
  UserDataUtils._();

  // ========== Auth 관련 데이터 ==========
  
  /// 사용자 ID 가져오기
  Future<int?> getUserId() async {
    try {
      final storage = await AuthStorageService.getInstance();
      return storage.getUserId();
    } catch (error) {
      print('❌ 사용자 ID 가져오기 실패: $error');
      return null;
    }
  }

  /// 사용자 닉네임 가져오기
  Future<String?> getNickname() async {
    try {
      final storage = await AuthStorageService.getInstance();
      return storage.getNickname();
    } catch (error) {
      print('❌ 사용자 닉네임 가져오기 실패: $error');
      return null;
    }
  }

  /// 사용자 이메일 가져오기
  Future<String?> getEmail() async {
    try {
      final storage = await AuthStorageService.getInstance();
      return storage.getEmail();
    } catch (error) {
      print('❌ 사용자 이메일 가져오기 실패: $error');
      return null;
    }
  }

  /// 프로필 이미지 URL 가져오기
  Future<String?> getProfileImageUrl() async {
    try {
      final storage = await AuthStorageService.getInstance();
      return storage.getProfileImageUrl();
    } catch (error) {
      print('❌ 프로필 이미지 URL 가져오기 실패: $error');
      return null;
    }
  }

  // ========== Onboarding 관련 데이터 ==========
  
  /// 직업 정보 가져오기
  Future<String?> getJob() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      return storage.getJob();
    } catch (error) {
      print('❌ 직업 정보 가져오기 실패: $error');
      return null;
    }
  }

  /// 취미 목록 가져오기
  Future<List<String>?> getHobbies() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      return storage.getHobbies();
    } catch (error) {
      print('❌ 취미 목록 가져오기 실패: $error');
      return null;
    }
  }

  /// 표현 방식 가져오기
  Future<String?> getExpressionStyle() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      return storage.getExpressionStyle();
    } catch (error) {
      print('❌ 표현 방식 가져오기 실패: $error');
      return null;
    }
  }

  /// 캐릭터 타입 가져오기
  Future<String?> getCharacterType() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      return storage.getCharacterType();
    } catch (error) {
      print('❌ 캐릭터 타입 가져오기 실패: $error');
      return null;
    }
  }

  /// 캐릭터 이름 가져오기
  Future<String?> getCharacterName() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      return storage.getCharacterName();
    } catch (error) {
      print('❌ 캐릭터 이름 가져오기 실패: $error');
      return null;
    }
  }

  /// 자신 있는 방식 타입 가져오기
  Future<String?> getStrengthType() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      return storage.getStrengthType();
    } catch (error) {
      print('❌ 자신 있는 방식 타입 가져오기 실패: $error');
      return null;
    }
  }
}
