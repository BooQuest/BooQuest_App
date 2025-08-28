import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/revenue/application/providers/add_income_providers.dart';
import 'package:booquest/features/revenue/application/providers/update_income_providers.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';

/// 수익 추가/수정 모달 위젯
class AddIncomeModal extends ConsumerStatefulWidget {
  final int userSideJobId;
  final IncomeEntity? income; // 수정 모드일 때 사용
  final VoidCallback? onUpdateSuccess; // 수정 성공 시 콜백
  
  const AddIncomeModal({
    super.key,
    required this.userSideJobId,
    this.income,
    this.onUpdateSuccess,
  });

  @override
  ConsumerState<AddIncomeModal> createState() => _AddIncomeModalState();
}

class _AddIncomeModalState extends ConsumerState<AddIncomeModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    
    if (widget.income != null) {
      // 수정 모드: 기존 데이터로 필드 채우기
      _titleController.text = widget.income!.title;
      _amountController.text = _formatCurrency(widget.income!.amount);
      _dateController.text = widget.income!.incomeDate;
      _memoController.text = widget.income!.memo;
      
      // 날짜 파싱
      try {
        final dateParts = widget.income!.incomeDate.split('-');
        if (dateParts.length == 3) {
          _selectedDate = DateTime(
            int.parse(dateParts[0]),
            int.parse(dateParts[1]),
            int.parse(dateParts[2]),
          );
        }
      } catch (e) {
        // 파싱 실패 시 현재 날짜 사용
        _selectedDate = DateTime.now();
      }
    } else {
      // 추가 모드: 현재 날짜로 초기화
      _dateController.text = _formatDate(_selectedDate);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 드래그 핸들
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // 제목
              Center(
                child: Text(
                  widget.income != null ? '수익 수정' : '신규 수익 등록',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // 수익 내용
              _buildInputField(
                label: '수익 내용',
                controller: _titleController,
                hintText: '어떤 활동으로 수익을 얻으셨나요?',
              ),
              const SizedBox(height: 16),
              
              // 수익금
              _buildInputField(
                label: '수익금',
                controller: _amountController,
                hintText: '0 원',
                isAmount: true,
              ),
              const SizedBox(height: 16),
              
              // 일자
              _buildDateField(),
              const SizedBox(height: 16),
              
              // 메모
              _buildInputField(
                label: '메모',
                controller: _memoController,
                hintText: '메모를 입력하세요.',
              ),
              const SizedBox(height: 32),
              
              // 완료 버튼
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isFormValid() ? _handleSubmit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid() 
                        ? const Color(0xFF2196F3) 
                        : Colors.grey[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _buildButtonContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 입력 필드 위젯
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool isAmount = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              if (isAmount) {
                // 수익금 입력 시 자동으로 원화 표시 단위로 변환
                _formatAmountInput(controller, value);
              }
              setState(() {}); // 입력 변경 시 버튼 상태 업데이트
            },
            keyboardType: isAmount ? TextInputType.number : TextInputType.text,
            inputFormatters: isAmount ? [
              FilteringTextInputFormatter.digitsOnly,
            ] : null,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  /// 수익금 입력 시 자동으로 원화 표시 단위로 변환
  void _formatAmountInput(TextEditingController controller, String value) {
    // 숫자만 추출
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.isEmpty) {
      controller.text = '';
      controller.selection = const TextSelection.collapsed(offset: 0);
      return;
    }
    
    // 숫자를 정수로 변환
    final amount = int.tryParse(digitsOnly) ?? 0;
    
    // 천 단위 구분 쉼표 추가
    final formattedAmount = _formatCurrency(amount);
    
    // 텍스트 업데이트
    controller.text = formattedAmount;
    
    // 커서 위치 조정 (쉼표가 추가되면서 위치가 달라질 수 있음)
    final newPosition = controller.text.length;
    controller.selection = TextSelection.collapsed(offset: newPosition);
  }

  /// 통화 포맷팅 (123,456 형태)
  String _formatCurrency(int amount) {
    if (amount == 0) return '';
    
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return amount.toString().replaceAllMapped(formatter, (Match m) => '${m[1]},');
  }

  /// 폼 유효성 검사
  bool _isFormValid() {
    return _titleController.text.trim().isNotEmpty &&
           _amountController.text.trim().isNotEmpty &&
           _dateController.text.trim().isNotEmpty &&
           _memoController.text.trim().isNotEmpty;
  }

  /// 제출 처리
  Future<void> _handleSubmit() async {
    if (!_isFormValid()) return;

    try {
      // 수익금에서 쉼표 제거 후 파싱
      final amountText = _amountController.text.trim().replaceAll(',', '');
      final amount = int.tryParse(amountText) ?? 0;
      
      if (widget.income != null) {
        // 수정 모드
        await ref.read(updateIncomeNotifierProvider.notifier).updateIncome(
          incomeId: widget.income!.id,
          title: _titleController.text.trim(),
          amount: amount,
          incomeDate: _dateController.text.trim(),
          memo: _memoController.text.trim(),
        );
        
        // 수정 성공 시 콜백 호출
        if (mounted) {
          Navigator.of(context).pop();
          widget.onUpdateSuccess?.call();
        }
      } else {
        // 추가 모드
        await ref.read(addIncomeNotifierProvider.notifier).addIncome(
          userSideJobId: widget.userSideJobId,
          title: _titleController.text.trim(),
          amount: amount,
          incomeDate: _dateController.text.trim(),
          memo: _memoController.text.trim(),
        );
        
        // 추가 성공 시 모달 닫기
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      print('Error submitting form: $e');
    }
  }

  /// 버튼 내용 구성
  Widget _buildButtonContent() {
    if (widget.income != null) {
      // 수정 모드: update 상태 감시
      final updateIncomeState = ref.watch(updateIncomeNotifierProvider);
      
      return updateIncomeState.when(
        initial: () => const Text(
          '수정 완료',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        loading: () => const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        success: (_) => const Text(
          '수정 완료',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        failure: (_) => const Text(
          '수정 완료',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    } else {
      // 추가 모드: add 상태 감시
      final addIncomeState = ref.watch(addIncomeNotifierProvider);
      
      return addIncomeState.when(
        initial: () => const Text(
          '완료',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        loading: () => const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        success: (_) => const Text(
          '완료',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
        ),
        ),
        failure: (_) => const Text(
          '완료',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
  }

  /// 날짜 선택 필드 위젯
  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '일자 *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Text(
                      _dateController.text,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
