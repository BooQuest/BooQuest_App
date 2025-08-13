import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  bool _stage1Expanded = false;
  bool _stage2Expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed top bar
            _buildTopBar(),
            const SizedBox(height: 20),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverallProgress(),
                    const SizedBox(height: 28),
                    _buildInProgressHeader(),
                    const SizedBox(height: 12),
                    _QuestStageCard(
                      stepLabel: '1단계',
                      title: '블로그 기반 구축 & 운영준비',
                      progress: 0.7,
                      expanded: _stage1Expanded,
                      onToggle: () => setState(() => _stage1Expanded = !_stage1Expanded),
                      child: const _Stage1Detail(),
                    ),
                    const SizedBox(height: 16),
                    _QuestStageCard(
                      stepLabel: '2단계',
                      title: '키워드 & 콘텐츠 전략 설계',
                      progress: 0.7,
                      expanded: _stage2Expanded,
                      onToggle: () => setState(() => _stage2Expanded = !_stage2Expanded),
                      child: const _Stage2Detail(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Center(
              child: Text(
                '퀘스트',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings, color: AppColors.textPrimary),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '전체 진행률',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '15%',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            height: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildInProgressHeader() {
    return Row(
      children: const [
        Expanded(
          child: Text(
            '진행중인 퀘스트',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Icon(Icons.chevron_right, color: AppColors.textPrimary),
      ],
    );
  }
}

class _QuestStageCard extends StatelessWidget {
  final String stepLabel;
  final String title;
  final double progress;
  final bool expanded;
  final VoidCallback onToggle;
  final Widget child;

  const _QuestStageCard({
    required this.stepLabel,
    required this.title,
    required this.progress,
    required this.expanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEDED),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          stepLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _ProgressBar(value: progress),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onToggle,
                  icon: Icon(
                    expanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          if (expanded)
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
          if (expanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: child,
            ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value; // 0.0 ~ 1.0
  const _ProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${(value * 100).round()}%',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFFEDEDED),
            borderRadius: BorderRadius.circular(100),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Stage1Detail extends StatelessWidget {
  const _Stage1Detail();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F0F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.article, color: AppColors.textHint),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                '블로그 플랫폼 선택 & 기본 설정',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SkeletonBar(widthFactor: 0.8),
        const SizedBox(height: 8),
        _SkeletonBar(widthFactor: 0.6),
        const SizedBox(height: 8),
        _SkeletonBar(widthFactor: 0.9),
        const SizedBox(height: 16),
        _QuestItemTile(index: 1, title: '블로그 플랫폼 선택'),
        const SizedBox(height: 12),
        _QuestItemTile(index: 2, title: '도메인 설정'),
        const SizedBox(height: 12),
        _QuestItemTile(index: 3, title: '기본 레이아웃 구성'),
      ],
    );
  }
}

class _Stage2Detail extends StatelessWidget {
  const _Stage2Detail();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F0F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.image, color: AppColors.textHint),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                '100만명이 선택한 핵심 키워드 Top3',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SkeletonBar(widthFactor: 0.7),
        const SizedBox(height: 8),
        _SkeletonBar(widthFactor: 0.9),
        const SizedBox(height: 8),
        _SkeletonBar(widthFactor: 0.6),
        const SizedBox(height: 16),
        _QuestItemTile(index: 1, title: '핵심 키워드 분석'),
        const SizedBox(height: 12),
        _QuestItemTile(index: 2, title: '콘텐츠 주제 선정'),
        const SizedBox(height: 12),
        _QuestItemTile(index: 3, title: '콘텐츠 캘린더 작성'),
      ],
    );
  }
}

class _SkeletonBar extends StatelessWidget {
  final double widthFactor;
  const _SkeletonBar({required this.widthFactor});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 14,
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _QuestItemTile extends StatelessWidget {
  final int index;
  final String title;
  const _QuestItemTile({required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimary),
          ],
        ),
      ),
    );
  }
}
