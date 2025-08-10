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
Add Hive/Isar when necessary
Apply caching only for complex logic

10. Internationalization (i18n)

Use Flutter Intl
Manage all strings through localization files
Initially support Korean/English only