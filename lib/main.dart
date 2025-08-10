import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/data/auth_repository_impl.dart';
import 'package:booquest/features/auth/presentation/auth_provider.dart';
import 'package:booquest/features/auth/presentation/login_screen.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  
  // 개발 환경일 때만 .env 파일 로드
  // if (const String.fromEnvironment('FLUTTER_ENV') != 'production') {
    // await dotenv.load(fileName: ".env");
  // }
  
  // NetworkClient 초기화
  NetworkClient().initialize();
  
  // 앱 시작 시 인증 상태 확인을 위한 Provider 생성
  final authProvider = AuthProvider(AuthRepositoryImpl(NetworkClient()));
  
  // 앱 시작 시 인증 상태 확인
  await authProvider.checkAuthStatus();
  
  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;
  
  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: authProvider,
      child: MaterialApp(
        title: 'BooQuest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

/// 인증 상태에 따라 적절한 화면을 보여주는 래퍼 위젯
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // 로딩 중일 때
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        // 인증된 사용자일 때 메인 화면으로, 아니면 로그인 화면으로
        if (authProvider.isAuthenticated) {
          return const MainScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

/// 메인 화면 (인증된 사용자용)
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BooQuest'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // 로그아웃 처리
              context.read<AuthProvider>().logout();
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              '로그인 성공!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '메인 화면입니다.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
