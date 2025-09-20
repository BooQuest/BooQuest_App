import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:booquest/core/constants.dart';

/// 버전 체크 서비스
/// 
/// 서버 API를 통해 최신 버전을 확인하고
/// 플랫폼별로 다른 업데이트 방식을 제공합니다.
class VersionCheckService {
  static const String _baseUrl = AppConstants.baseUrl;
  final Dio _dio = Dio();

  /// 서버에서 최신 버전 정보 가져오기
  /// 
  /// [platform] 플랫폼 (ANDROID, IOS)
  /// Returns: 최신 버전 정보 또는 null
  Future<Map<String, dynamic>?> getLatestVersion(String platform) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/api/version',
        queryParameters: {'platform': platform},
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as Map<String, dynamic>?;
        if (data != null) {
          print('📱 버전 정보: ${data['latestVersion']} (${data['latestBuildNumber']}) - 강제업데이트: ${data['isForceUpdate']}');
        }
        return data;
      }

      print('❌ 버전 체크 API 응답 오류: ${response.data}');
      return null;
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        print('❌ DNS 조회 실패: 서버 도메인을 찾을 수 없습니다. API URL을 확인해주세요.');
      } else if (e.toString().contains('connection error')) {
        print('❌ 네트워크 연결 오류: 인터넷 연결을 확인해주세요.');
      } else {
        print('❌ 버전 체크 API 호출 실패: $e');
      }
      return null;
    }
  }

  /// 현재 앱 버전 정보 가져오기
  Future<Map<String, String>> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return {
      'version': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
    };
  }

  /// 버전 비교하여 업데이트 필요 여부 확인
  /// 
  /// [currentVersion] 현재 버전
  /// [currentBuildNumber] 현재 빌드 번호
  /// [latestVersion] 최신 버전
  /// [latestBuildNumber] 최신 빌드 번호
  /// Returns: 업데이트 필요 여부
  bool isUpdateRequired({
    required String currentVersion,
    required String currentBuildNumber,
    required String latestVersion,
    required String latestBuildNumber,
  }) {
    // 버전 비교 (major.minor.patch)
    final currentVersionParts = _parseVersion(currentVersion);
    final latestVersionParts = _parseVersion(latestVersion);
    
    // Major 버전 비교
    if (latestVersionParts[0] > currentVersionParts[0]) return true;
    if (latestVersionParts[0] < currentVersionParts[0]) return false;
    
    // Minor 버전 비교
    if (latestVersionParts[1] > currentVersionParts[1]) return true;
    if (latestVersionParts[1] < currentVersionParts[1]) return false;
    
    // Patch 버전 비교
    if (latestVersionParts[2] > currentVersionParts[2]) return true;
    if (latestVersionParts[2] < currentVersionParts[2]) return false;
    
    // 빌드 번호 비교 (둘 다 String으로 통일)
    final currentBuild = int.tryParse(currentBuildNumber) ?? 0;
    final latestBuild = int.tryParse(latestBuildNumber.toString()) ?? 0;
    
    return latestBuild > currentBuild;
  }

  /// 버전 문자열을 파싱하여 [major, minor, patch] 배열로 변환
  List<int> _parseVersion(String version) {
    final parts = version.split('.').map(int.tryParse).toList();
    return [
      parts[0] ?? 0,
      parts[1] ?? 0,
      parts[2] ?? 0,
    ];
  }
}
