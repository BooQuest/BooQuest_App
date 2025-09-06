import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';

/// 부업 가이드 팝업
/// 부업 가이드 버튼 클릭 시 하단에서 올라오는 팝업창
class SidejobGuidePopup extends StatelessWidget {
  final List<MissionEntity> missions;
  
  const SidejobGuidePopup({
    super.key,
    required this.missions,
  });

  /// 가이드 데이터 파싱
  Map<String, dynamic> _parseGuideData(String? guideText) {
    if (guideText == null || guideText.isEmpty) {
      return {
        'title': '부업 가이드',
        'description': '부업 성공을 위한 단계별 가이드입니다.',
        'steps': [],
      };
    }

    final lines = guideText.split('\n').where((line) => line.trim().isNotEmpty).toList();
    final steps = <Map<String, String>>[];
    String currentDescription = '';
    
    for (final line in lines) {
      final trimmedLine = line.trim();
      
      if (trimmedLine.startsWith('**') && trimmedLine.contains('.')) {
        // **1. 제목** 형식의 단계 - 번호 제거
        final titleWithNumber = trimmedLine.substring(2).replaceAll('**', '').trim();
        // "1. " 또는 "2. " 등의 번호 패턴 제거
        final title = titleWithNumber.replaceAll(RegExp(r'^\d+\.\s*'), '');
        steps.add({
          'title': title,
          'description': '',
        });
        currentDescription = '';
      } else if (trimmedLine.startsWith('- ')) {
        // - 설명 형식
        final description = trimmedLine.substring(2).trim();
        if (steps.isNotEmpty) {
          if (currentDescription.isNotEmpty) {
            currentDescription += ' ';
          }
          currentDescription += description;
          steps.last['description'] = currentDescription;
        }
      }
    }

    print('🔍 파싱된 steps 개수: ${steps.length}');
    for (int i = 0; i < steps.length; i++) {
      print('  [$i] title: ${steps[i]['title']}, description: ${steps[i]['description']}');
    }

    return {
      'title': '부업 가이드',
      'description': '부업 성공을 위한 단계별 가이드입니다.',
      'steps': steps,
    };
  }

  @override
  Widget build(BuildContext context) {
    // 현재 미션의 가이드 데이터 파싱
    final currentMission = missions.isNotEmpty ? missions.first : null;
    final guideData = _parseGuideData(currentMission?.guide);
    
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 드래그 핸들
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // 제목 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '키워드 & 콘텐츠 전략 설계',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '이렇게 하세요!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '부업의 출발점이자 성장의 방향을\n결정짓는 핵심 단계예요.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          // 가이드 단계들 (회색 카드 배경)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8), // 회색 배경
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: _buildGuideSteps(guideData['steps'] ?? []),
            ),
          ),
          
          // 하단 여백
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 가이드 단계들 생성 
  List<Widget> _buildGuideSteps(List<dynamic> steps) {
    if (steps.isEmpty) {
      return [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              '가이드 정보가 없습니다.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ),
      ];
    }

    final List<Widget> widgets = [];
    for (int i = 0; i < steps.length; i++) {
      final step = steps[i] as Map<String, String>;
      widgets.add(
        _buildGuideStep(
          number: i + 1,
          title: step['title'] ?? '',
          description: step['description'] ?? '',
        ),
      );
      
      if (i < steps.length - 1) {
        widgets.add(const SizedBox(height: 24));
      }
    }
    
    return widgets;
  }

  /// 가이드 단계 위젯
  Widget _buildGuideStep({
    required int number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 단계 번호 원형 배경 (더 깔끔한 스타일)
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0), // 연한 회색
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFD0D0D0),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF666666), // 회색 숫자
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        
        // 제목과 설명
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
