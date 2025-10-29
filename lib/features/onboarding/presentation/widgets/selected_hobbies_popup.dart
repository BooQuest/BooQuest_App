import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/utils/debouncer.dart';

/// 취미 세부 옵션 선택 팝업
/// 선택한 취미 카드에 대한 세부 옵션들을 선택할 수 있는 팝업
class SelectedHobbiesPopup extends StatefulWidget {
  final List<String> selectedHobbies;
  final VoidCallback? onConfirm;
  
  const SelectedHobbiesPopup({
    super.key,
    required this.selectedHobbies,
    this.onConfirm,
  });

  @override
  State<SelectedHobbiesPopup> createState() => _SelectedHobbiesPopupState();
}

class _SelectedHobbiesPopupState extends State<SelectedHobbiesPopup> {
  // 선택된 세부 옵션들을 저장
  final Set<String> _selectedDetails = <String>{};
  
  // Debouncer 추가
  late final Debouncer _saveDebouncer;
  
  @override
  void initState() {
    super.initState();
    _saveDebouncer = Debouncer(OnboardingDebouncer.inputDelay);
    _loadSavedDetails(); // 저장된 세부 옵션 불러오기
  }
  
  @override
  void dispose() {
    _saveDebouncer.dispose();
    super.dispose();
  }

  // 취미 카테고리별 세부 옵션 매핑
  static const Map<String, List<String>> _hobbyDetails = {
    '경제·사회·재테크': ['재테크', '경제', '정치', '시사'],
    '문화·예술': ['음악', '영화·드라마·애니', '미술', '노래', '춤', '악기'],
    '뷰티·패션': ['메이크업', '패션', '다이어트', '피부 관리'],
    '연예·예능·밈': ['연예인·인플루언서', '예능', '유머·밈', '해외 예능·유튜브'],
    'IT·게임': ['게임', 'IT', '테크(전자기기 등)'],
    '언어·해외·여행': ['여행', '언어 학습', '해외 살이'],
    '교육·심리': ['지식전달', '자기계발', '학습법', '동기부여', '심리'],
    '요리·음식': ['요리', '먹방', '맛집', '카페', '디저트'],
    '헬스·건강': ['운동', '스포츠', '건강'],
    '가족·인간관계·라이프': ['육아', '결혼', '연애', '인간관계', '반려동물'],
  };

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    // 선택된 취미 개수에 따른 동적 높이 계산
    final selectedCount = widget.selectedHobbies.length;
    
    // 기본 높이 (제목 + 버튼 영역)
    final baseHeight = isLandscape ? 160.0 : 200.0;
    
    // 선택된 취미 개수에 따른 높이 조정
    double additionalHeight;
    if (selectedCount == 1) {
      // 1개 선택: 2-3줄 정도의 옵션 공간
      additionalHeight = isLandscape ? 100.0 : 120.0;
    } else if (selectedCount == 2) {
      // 2개 선택: 3-4줄 정도의 옵션 공간
      additionalHeight = isLandscape ? 140.0 : 160.0;
    } else {
      // 3개 선택: 4-5줄 정도의 옵션 공간
      additionalHeight = isLandscape ? 180.0 : 200.0;
    }
    
    // 최종 높이 계산
    final popupHeight = baseHeight + additionalHeight;
    
    return Container(
      width: double.infinity, // 화면 너비 100% 명시적 설정
      height: popupHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // 상단 드래그 핸들
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: 12, 
                bottom: isLandscape ? 12 : 16,
              ),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // 제목
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '최적의 추천을 위해',
                  style: TextStyle(
                    fontSize: isLandscape ? 18 : 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF202020),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '조금 더 자세히 알고 싶어요',
                  style: TextStyle(
                    fontSize: isLandscape ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF202020),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '최대 3개까지 선택 가능해요.',
                  style: TextStyle(
                    fontSize: isLandscape ? 14 : 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: isLandscape ? 12 : 16),
          
          // 세부 옵션 리스트 (스크롤 가능)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: isLandscape ? 8 : 12,
                runSpacing: isLandscape ? 8 : 12,
                children: _getAllDetailOptions().map((detail) => _buildSelectableDetailChip(detail)).toList(),
              ),
            ),
          ),
          
          SizedBox(height: isLandscape ? 12 : 16),
          
          // 완료 버튼
          Padding(
            padding: const EdgeInsets.only(
              left: 20, 
              right: 20, 
              bottom: 24,
            ),
            child: Container(
              width: double.infinity,
              height: isLandscape ? 44 : 48,
              decoration: BoxDecoration(
                color: _selectedDetails.isNotEmpty 
                    ? const Color(0xFF1976D2)
                    : const Color(0xFFCCCCCC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _selectedDetails.isNotEmpty ? widget.onConfirm : null,
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                    child: Text(
                      '완료',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isLandscape ? 15 : 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }

  /// 모든 세부 옵션들을 가져오는 메서드
  List<String> _getAllDetailOptions() {
    List<String> allOptions = [];
    for (String hobby in widget.selectedHobbies) {
      final details = _hobbyDetails[hobby] ?? [];
      allOptions.addAll(details);
    }
    return allOptions;
  }
  
  /// 저장된 세부 옵션 불러오기 (기존 취미 목록에서 세부 옵션만 필터링)
  Future<void> _loadSavedDetails() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final allHobbies = storage.getHobbies(); // 전체 취미 목록 가져오기
      
      // 전체 취미 목록에서 세부 옵션들만 필터링
      final allDetailOptions = _getAllDetailOptions();
      final savedDetails = allHobbies.where((hobby) => allDetailOptions.contains(hobby)).toList();
      
      if (savedDetails.isNotEmpty) {
        setState(() {
          _selectedDetails.addAll(savedDetails);
        });
      }
    } catch (error) {
      print('❌ 저장된 세부 옵션 불러오기 실패: $error');
    }
  }
  
  /// 세부 옵션 실시간 저장 (기존 취미 목록에 추가)
  Future<void> _saveDetailsRealtime() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final currentHobbies = storage.getHobbies(); // 현재 저장된 취미 목록
      
      // 기존 취미 목록에서 세부 옵션들 제거
      final allDetailOptions = _getAllDetailOptions();
      final filteredHobbies = currentHobbies.where((hobby) => !allDetailOptions.contains(hobby)).toList();
      
      // 새로운 목록: 기존 취미 + 선택된 세부 옵션들
      final newHobbies = [...filteredHobbies, ..._selectedDetails];
      
      await storage.setHobbies(newHobbies);
    } catch (error) {
      print('❌ 실시간 세부 옵션 저장 실패: $error');
    }
  }

  /// 선택 가능한 세부 옵션 칩 위젯
  Widget _buildSelectableDetailChip(String detail) {
    final isSelected = _selectedDetails.contains(detail);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedDetails.remove(detail);
          } else {
            // 최대 3개까지만 선택 가능
            if (_selectedDetails.length < 3) {
              _selectedDetails.add(detail);
            }
          }
        });
        
        // 실시간 저장 (Debouncer 적용)
        _saveDebouncer.run(() => _saveDetailsRealtime());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.chipSelectedBg : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.chipBorder : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Text(
          detail,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isSelected ? AppColors.chipSelectedText : Colors.grey,
          ),
        ),
      ),
    );
  }
}
