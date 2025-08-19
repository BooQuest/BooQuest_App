1. Architecture & Project Structure
Architecture Pattern

Use Clean Architecture + Feature-First structure
Dependency direction between layers: presentation → domain → data
Keep the domain layer even if simple. Write usecases only when absolutely necessary
Place common utilities/constants in core/, reusable widgets in shared/, and global configurations in config/
Implement OS-specific UI/features in platform/ folder or separate files by OS (file.android.dart, file.ios.dart)

Backend Integration
- Spring Boot backend with JWT authentication
- Repository pattern for Spring API communication
- Consistent data models between Flutter and Spring

Folder Structure Example
lib/
├── app/                # App entry point, global Providers, theme
├── config/             # Router, app global settings
├── core/               # Common utilities, constants, error handling, services
│   ├── network/
│   ├── exceptions/
│   └── constants.dart
├── shared/             # Shared widgets, extension functions (필요시만)
├── features/
│   ├── auth/           # 인증 기능
│   │   ├── data/       # 2-3개 파일 (repository, models)
│   │   ├── domain/     # 1개 파일 (interface)
│   │   └── presentation/ # 3-4개 파일 (provider, screen, widgets)
│   ├── home/           # 홈 기능
│   │   ├── data/       # 2-3개 파일
│   │   ├── domain/     # 1개 파일
│   │   └── presentation/ # 3-4개 파일
├── platform/           # OS-specific implementations (Android/iOS)
└── main.dart

2. State Management

Use Riverpod 2.x + riverpod_generator
Complex state (API calls, side effects): AsyncNotifierProvider
Simple local state: NotifierProvider
One-time async operations: FutureProvider
Real-time streams: StreamProvider

3. Networking & Data

Use Dio + Retrofit for Spring API calls
Use Freezed for data classes and JSON serialization
Apply Repository pattern for Spring backend communication
Unify errors with custom exceptions (NetworkException)
Apply offline-first and caching only when necessary

3.5. Backend Integration

Spring Backend Integration
- Use Spring Boot as primary backend
- Implement JWT-based authentication
- Follow RESTful API conventions
- Handle Spring API responses with proper error mapping
- Use consistent API response format across all endpoints

API Response Structure
- Standardize Spring API response format
- Implement proper error handling for HTTP status codes
- Use consistent data models between Flutter and Spring

4. UI/UX & Theming

Apply Material 3 as priority
Recommend other design packages (e.g., Cupertino, Fluent UI) when needed
Implement light/dark theme support according to requirements
Apply responsive layouts when necessary
Use flutter_hooks selectively

5. Navigation

Use GoRouter
Use declarative routing + route parameters
Implement route guards and deep links when necessary

6. Component Structure

Place feature-specific widgets in respective feature's presentation/widgets/
Place reusable widgets in shared/widgets/
Do not use Atomic Design categorization
Use StatelessWidget / StatefulWidget / HookWidget
Actively utilize const constructors

7. Animation & Interactions

Prioritize Flutter built-in animation widgets (AnimatedContainer, AnimatedOpacity, etc.)
Use external packages like Lottie, Rive for complex animations when needed

8. Development Tools & Code Quality

Apply very_good_analysis or default flutter_lints
Run dart format before commits
Maintain code quality with flutter analyze
Do not write unit tests

9. Local Storage & Security

Simple key-value storage: SharedPreferences
Sensitive information: flutter_secure_storage

 9.1 OnboardingStorageService (온보딩 전용)
  - 역할: 온보딩 과정에서 수집되는 사용자 데이터 저장
  - 데이터: 캐릭터 이름, 타입, 직업, 취미, 표현 방식, 강점 타입, 현재 단계
  - 사용처: 모든 온보딩 화면 (step0~step4)
 9.2 LocalStorageService (앱 전반 설정)
  - 역할: 앱의 전반적인 설정과 상태 정보 관리 
  - 데이터: 온보딩 완료 여부, 앱 버전, 첫 실행 여부
  - 사용처: 앱 시작 시 라우팅 결정, 앱 설정 관리

10. Internationalization (i18n)

Use Flutter Intl
Manage all strings through localization files
Initially support Korean/English only

11. Flutter iOS/Android Guidelines 

Platform-Specific Handling

Use Platform.isIOS / Platform.isAndroid to separate platform-specific logic
Always implement platform branching for features that behave differently on iOS/Android

Responsive Layout

Avoid hardcoded sizes - use MediaQuery or LayoutBuilder
Breakpoints: 600px (mobile), 1024px (tablet)
Handle orientation changes with OrientationBuilder

iOS-Specific Requirements

Use SafeArea to handle notch areas
Consider swipe-back gesture behavior
Use CupertinoPageRoute for navigation

Android-Specific Requirements

Handle hardware back button with WillPopScope
Consider transparent status bar handling
Use MaterialPageRoute for navigation

Performance Optimization

Set cacheExtent when using ListView.builder
Check conditional widgets only once at build time
Keyboard handling: resizeToAvoidBottomInset + SingleChildScrollView

Common Utilities

Create PlatformUtils class for platform-specific value selection
Manage responsive breakpoints with Breakpoints constants
Create DeviceUtils for screen size information helpers




12. 구조

- Auth

┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                      │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐ │
│  │   AuthWrapper   │  │   LoginPage     │  │  MyScreen   │ │
│  │                 │  │                 │  │             │ │
│  └─────────────────┘  └─────────────────┘  └─────────────┘ │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                   APPLICATION LAYER                        │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                AuthNotifier                         │   │
│  │  - StateNotifier<AuthState>                        │   │
│  │  - 비즈니스 로직 처리                               │   │
│  │  - Infrastructure 계층 조합                         │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                  INFRASTRUCTURE LAYER                      │
│  ┌─────────────────┐  ┌─────────────────────────────────┐ │
│  │ AuthApiService  │  │      AuthStorageService         │ │
│  │                 │  │                                 │ │
│  │ - HTTP API 호출  │  │ - SharedPreferences 관리        │ │
│  │ - Dio 기반       │  │ - JWT 토큰 저장/삭제           │ │
│  └─────────────────┘  └─────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                           │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                  AuthState                          │   │
│  │  - isLoading: bool                                 │   │
│  │  - isAuthenticated: bool                           │   │
│  │  - user: Map<String, dynamic>?                     │   │
│  │  - errorMessage: String?                           │   │
│  │  - copyWith() 메서드                                │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘

- Sidejob

lib/features/sidejob/
├── domain/                           ✅ 완료
│   ├── sidejob_entity.dart          # 부업 추천 결과 모델
│   ├── sidejob_failure.dart         # 실패/에러 모델  
│   └── sidejob_repository.dart      # 추상 Repository 인터페이스
├── application/                      ✅ 완료
│   ├── sidejob_state.dart           # 상태 클래스
│   ├── sidejob_notifier.dart        # StateNotifier (UI 상태 + 로직)
│   └── get_sidejob_recommendations.dart # UseCase (실행 단위)
└── infrastructure/                   ✅ 완료
    ├── sidejob_repository_impl.dart # 실제 Repository 구현체
    ├── sidejob_api_service.dart     # API 호출 담당
    ├── user_data_service.dart       # UserDataUtils 역할
    └── sidejob_providers.dart       # Riverpod Provider 설정

