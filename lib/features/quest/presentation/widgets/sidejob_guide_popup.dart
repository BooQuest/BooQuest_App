import 'package:flutter/material.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';

/// 부업 가이드 팝업
/// 부업 가이드 버튼 클릭 시 하단에서 올라오는 팝업창
class SidejobGuidePopup extends StatelessWidget {
  final List<MissionEntity> missions;
  
  const SidejobGuidePopup({
    super.key,
    required this.missions,
  });

  /// 가이드 데이터 파싱 (steps 배열에서 데이터 추출)
  Map<String, dynamic> _parseGuideData(List<MissionEntity> missions) {
    if (missions.isEmpty) {
      return {
        'title': '부업 가이드',
        'description': '부업 성공을 위한 단계별 가이드입니다.',
        'steps': [],
      };
    }

    final currentMission = missions.first;
    final steps = <Map<String, dynamic>>[];
    
    // steps 배열을 seq 순서대로 정렬
    final sortedSteps = List.from(currentMission.steps)
      ..sort((a, b) => (a.seq ?? 0).compareTo(b.seq ?? 0));
    
    for (final step in sortedSteps) {
      steps.add({
        'seq': step.seq ?? 0,
        'title': step.title ?? '',
        'description': step.detail ?? '',
      });
    }

    return {
      'title': currentMission.title,
      'description': '부업 성공을 위한 단계별 가이드입니다.',
      'steps': steps,
    };
  }

  @override
  Widget build(BuildContext context) {
    // 현재 미션의 가이드 데이터 파싱
    final guideData = _parseGuideData(missions);
    
    // 화면 크기 계산
    final screenHeight = MediaQuery.of(context).size.height;
    
    // 팝업 높이 계산 (화면 높이의 80%, 최소 400px, 최대 600px)
    final double popupHeight = screenHeight * 0.8;
    
    return Container(
      height: popupHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
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
            
            // 스크롤 가능한 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // 제목 영역
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guideData['title'] ?? '부업 가이드',
                          style: const TextStyle(
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
                      ],
                    ),
                  ),
          
                  // 가이드 단계들 (회색 카드 배경)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8), // 회색 배경
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: _buildGuideSteps(guideData['steps'] ?? []),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
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
      final step = steps[i] as Map<String, dynamic>;
      widgets.add(
        _buildGuideStep(
          number: step['seq'] ?? (i + 1),
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
