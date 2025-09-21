import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

/// 강제/선택 업데이트 다이얼로그
/// 
/// isForceUpdate 값에 따라 다른 다이얼로그를 표시합니다.
/// - true: 강제 업데이트 (취소 버튼 없음)
/// - false: 선택 업데이트 (취소 버튼 있음)
class ForceUpdateDialog extends StatelessWidget {
  final bool isForceUpdate;
  final String latestVersion;
  final int latestBuildNumber;
  final String description;

  const ForceUpdateDialog({
    super.key,
    required this.isForceUpdate,
    required this.latestVersion,
    required this.latestBuildNumber,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _buildIOSDialog(context);
    } else {
      return _buildAndroidDialog(context);
    }
  }

  /// iOS 다이얼로그 빌드
  Widget _buildIOSDialog(BuildContext context) {
    if (isForceUpdate) {
      return _buildIOSForceDialog(context);
    } else {
      return _buildIOSOptionalDialog(context);
    }
  }

  /// iOS 강제 업데이트 다이얼로그
  Widget _buildIOSForceDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('업데이트 필요', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Text(
            '새로운 버전 $latestVersion+$latestBuildNumber이 출시되었습니다.\n\n${_formatIOSDescription(description)}\n\n업데이트를 완료해야 앱을 사용할 수 있습니다.',
            style: const TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel, height: 1.4),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
            _handleIOSUpdate(context);
          },
          isDefaultAction: true,
          child: const Text('App Store에서 업데이트', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  /// iOS 선택 업데이트 다이얼로그
  Widget _buildIOSOptionalDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('업데이트 가능', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Text(
            '새로운 버전 $latestVersion+$latestBuildNumber이 출시되었습니다.\n\n${_formatIOSDescription(description)}\n\n업데이트하시겠습니까?',
            style: const TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel, height: 1.4),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('나중에'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
            _handleIOSUpdate(context);
          },
          isDefaultAction: true,
          child: const Text('업데이트', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  /// Android 다이얼로그 빌드
  Widget _buildAndroidDialog(BuildContext context) {
    if (isForceUpdate) {
      return _buildAndroidForceDialog(context);
    } else {
      return _buildAndroidOptionalDialog(context);
    }
  }

  /// Android 강제 업데이트 다이얼로그
  Widget _buildAndroidForceDialog(BuildContext context) {
    return PopScope(
      canPop: false, // 뒤로가기 비활성화
      child: AlertDialog(
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        title: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1000),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.bounceOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.3 + (0.7 * value),
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Text(
                  '업데이트 필요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
            );
          },
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
                children: [
                  const TextSpan(text: '새로운 버전 '),
                  TextSpan(
                    text: '$latestVersion+$latestBuildNumber',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const TextSpan(text: '이 출시되었습니다'),
                ],
              ),
            ),
            if (description.isNotEmpty && description != '정보 없음') ...[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '업데이트 내용',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: 0.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._buildUpdateList(description, context),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '업데이트 후 계속 이용하실 수 있습니다',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleAndroidUpdate(context);
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '지금 업데이트',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Android 선택 업데이트 다이얼로그
  Widget _buildAndroidOptionalDialog(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 16, 20),
      title: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1000),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.bounceOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.3 + (0.7 * value),
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Text(
                '업데이트',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                  letterSpacing: 0.15,
                ),
              ),
            ),
          );
        },
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
              children: [
                const TextSpan(text: '새로운 버전 '),
                TextSpan(
                  text: '$latestVersion+$latestBuildNumber',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const TextSpan(text: '이 출시되었습니다'),
              ],
            ),
          ),
          if (description.isNotEmpty && description != '정보 없음') ...[
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '업데이트 내용',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                      letterSpacing: 0.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._buildUpdateList(description, context),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.new_releases_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    '새로운 기능과 개선사항 포함',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF1976D2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '나중에',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _handleAndroidUpdate(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '업데이트',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// iOS용 description 포맷팅 (줄넘김 처리)
  String _formatIOSDescription(String description) {
    if (description.isEmpty || description == '정보 없음') {
      return '';
    }
    
    final items = description.split('-')
        .where((item) => item.trim().isNotEmpty)
        .map((item) => item.trim())
        .toList();
    
    if (items.isEmpty) {
      return '';
    }
    
    return items.map((item) => '• $item').join('\n');
  }

  /// 업데이트 내용을 리스트로 변환
  List<Widget> _buildUpdateList(String description, BuildContext context) {
    if (description.isEmpty || description == '정보 없음') {
      return [];
    }
    
    final items = description.split('-')
        .where((item) => item.trim().isNotEmpty)
        .map((item) => item.trim())
        .toList();
    
    if (items.isEmpty) {
      return [];
    }
    
    return items.map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(top: 8, right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.4,
                letterSpacing: 0.25,
              ),
            ),
          ),
        ],
      ),
    )).toList();
  }

  /// iOS 업데이트 처리
  Future<void> _handleIOSUpdate(BuildContext context) async {
    try {
      
      // App Store URL 생성
      const String appStoreUrl = 'https://apps.apple.com/app/id6751897728'; // BooQuest 앱 ID
      
      final Uri url = Uri.parse(appStoreUrl);
      
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // 에러 처리
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('App Store를 열 수 없습니다')),
          );
        }
      }
    } catch (e) {
    }
  }

  /// Android 업데이트 처리
  Future<void> _handleAndroidUpdate(BuildContext context) async {
    try {
      // Play Store URL 생성
      const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.booquest.app'; // 실제 패키지명으로 변경 필요
      
      final Uri url = Uri.parse(playStoreUrl);
      
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // 에러 처리
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Play Store를 열 수 없습니다')),
          );
        }
      }
    } catch (e) {
    }
  }
}