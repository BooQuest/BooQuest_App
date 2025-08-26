import 'package:flutter/material.dart';

/// 앱 전체에서 사용하는 색상 상수들
/// Figma 디자인 시스템에 맞춰 정의
class AppColors {
  // 기본 색상
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // 텍스트 색상
  static const Color textPrimary = Color(0xFF202020);      // 주요 텍스트
  static const Color textSecondary = Color(0xFF242424);    // 보조 텍스트
  static const Color textHint = Color(0xFF868686);         // 힌트 텍스트
  
  // 배경 색상
  static const Color background = Color(0xFFFFFFFF);       // 메인 배경
  static const Color inputBackground = Color(0xFFF8F8F8);  // 입력 필드 배경
  
  // 테두리 색상
  static const Color inputBorder = Color(0xFF545F71);      // 입력 필드 테두리
  static const Color avatarBorder = Color(0xFFBBBBBB);     // 아바타 테두리
  static const Color cardBorder = Color(0xFFE0E0E0);      // 카드 테두리
  
  // 버튼 색상
  static const Color buttonActive = Color(0xFF525252);     // 활성화된 버튼
  static const Color buttonInactive = Color(0xFFCCCCCC);   // 비활성화된 버튼
  static const Color buttonText = Color(0xFFFFFFFF);       // 버튼 텍스트
  static const Color buttonSecondary = Color(0xFFE7E7E7);  // 보조 버튼 배경 (이전)
  
  // 아바타 색상
  static const Color avatarBackground = Color(0x00000000); // 아바타 배경 (투명)
  static const Color avatarIcon = Color(0xFFFFFFFF);       // 아바타 아이콘
  
  // 투명도 색상
  static const Color overlayLight = Color(0x00000000);     // 연한 오버레이 (투명도 조절용)

  // 온보딩 진행 바 색상
  static const Color progressActive = Color(0xFFACACAC);   // 활성 바 (#ACACAC)
  static const Color progressInactive = Color(0xFFEBEBEB); // 비활성 바 (#EBEBEB)
  
  // 주요 색상
  static const Color primary = Color(0xFF007AFF);          // 주요 색상 (파란색)

  // 칩 색상
  static const Color chipSelectedBg = buttonActive;        // 선택 칩 배경
  static const Color chipSelectedText = white;             // 선택 칩 텍스트
  static const Color chipUnselectedBg = white;             // 비선택 칩 배경
  static const Color chipUnselectedText = black;           // 비선택 칩 텍스트
  static const Color chipBorder = black;                   // 칩 테두리
}
