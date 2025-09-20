import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:booquest/core/services/version_check_service.dart';
import 'package:booquest/core/presentation/widgets/force_update_dialog.dart';

/// 강제 업데이트 서비스
/// 
/// 서버 API를 통해 버전을 체크하고 플랫폼별로 다른 업데이트 방식을 제공합니다.
/// - iOS: App Store로 이동
/// - Android: Play Store로 이동
class ForceUpdateService {
  final VersionCheckService _versionCheckService = VersionCheckService();

  /// 강제 업데이트 체크 및 실행
  /// 
  /// 서버 API를 통해 최신 버전을 확인하고
  /// 플랫폼에 따라 스토어로 이동합니다.
  /// 
  /// Returns: true if update is required, false otherwise
  Future<bool> checkAndForceUpdate(BuildContext context) async {
    try {
      // 1. 현재 앱 버전 정보 가져오기
      final currentVersionInfo = await _versionCheckService.getCurrentVersion();
      final currentVersion = currentVersionInfo['version']!;
      final currentBuildNumber = currentVersionInfo['buildNumber']!;

      print('📱 현재 버전: $currentVersion ($currentBuildNumber)');

      // 2. 플랫폼별 최신 버전 정보 가져오기
      final platform = Platform.isIOS ? 'IOS' : 'ANDROID';
      final latestVersionInfo = await _versionCheckService.getLatestVersion(platform);
      
      if (latestVersionInfo == null) {
        print('❌ 최신 버전 정보를 가져올 수 없습니다.');
        return false;
      }

      final latestVersion = latestVersionInfo['latestVersion'] as String;
      final latestBuildNumber = latestVersionInfo['latestBuildNumber'].toString();
      final isForceUpdate = latestVersionInfo['isForceUpdate'] as bool? ?? false;
      final description = latestVersionInfo['description'] as String? ?? '새로운 기능과 개선사항이 포함되었습니다.';

      print('🔄 최신 버전: $latestVersion ($latestBuildNumber) - 강제업데이트: $isForceUpdate');

      // 3. 업데이트 필요 여부 확인
      final needsUpdate = _versionCheckService.isUpdateRequired(
        currentVersion: currentVersion,
        currentBuildNumber: currentBuildNumber,
        latestVersion: latestVersion,
        latestBuildNumber: latestBuildNumber,
      );

      if (needsUpdate) {
        print('🔄 업데이트 필요 - 다이얼로그 표시 (강제: $isForceUpdate)');
        await _showUpdateDialog(context, isForceUpdate, latestVersion, int.parse(latestBuildNumber), description);
        return true;
      } else {
        print('✅ 최신 버전입니다.');
        return false;
      }
    } catch (e) {
      print('❌ 강제 업데이트 체크 중 오류 발생: $e');
      return false;
    }
  }

  /// 업데이트 다이얼로그 표시
  Future<void> _showUpdateDialog(BuildContext context, bool isForceUpdate, String latestVersion, int latestBuildNumber, String description) async {
    if (Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        barrierDismissible: !isForceUpdate, // 강제 업데이트가 아닌 경우에만 외부 터치로 닫기 가능
        builder: (context) => ForceUpdateDialog(
          isForceUpdate: isForceUpdate,
          latestVersion: latestVersion,
          latestBuildNumber: latestBuildNumber,
          description: description,
        ),
      );
    } else {
      await showDialog(
        context: context,
        barrierDismissible: !isForceUpdate, // 강제 업데이트가 아닌 경우에만 외부 터치로 닫기 가능
        builder: (context) => ForceUpdateDialog(
          isForceUpdate: isForceUpdate,
          latestVersion: latestVersion,
          latestBuildNumber: latestBuildNumber,
          description: description,
        ),
      );
    }
  }


}
