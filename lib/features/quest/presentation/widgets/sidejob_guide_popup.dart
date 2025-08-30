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

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  missions.isNotEmpty ? missions.first.title : '부업 가이드',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '이렇게 하세요!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  missions.isNotEmpty && missions.first.guide != null 
                      ? missions.first.guide! 
                      : '아쉬웠던 점을 모두 선택해주세요.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // 동적 가이드 단계
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: _buildDynamicGuideSteps(),
            ),
          ),
          
          // 하단 여백
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 동적 가이드 단계 생성
  List<Widget> _buildDynamicGuideSteps() {
    // orderNo 순서대로 정렬
    final sortedMissions = List<MissionEntity>.from(missions)
      ..sort((a, b) => (a.orderNo ?? 0).compareTo(b.orderNo ?? 0));
    
    final List<Widget> widgets = [];
    
    for (int i = 0; i < sortedMissions.length; i++) {
      final mission = sortedMissions[i];
      
      widgets.add(
        _buildGuideStep(
          number: i + 1,
          title: mission.title,
          description: mission.guide ?? '가이드 정보가 없습니다.',
        ),
      );
      
      // 마지막 항목이 아니면 간격 추가
      if (i < sortedMissions.length - 1) {
        widgets.add(const SizedBox(height: 20));
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
        // 단계 번호 원형 배경
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // 제목과 설명
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
