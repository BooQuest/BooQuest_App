// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booquest/main.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/data/auth_repository_impl.dart';
import 'package:booquest/features/auth/presentation/auth_provider.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    NetworkClient().initialize();
    final authProvider = AuthProvider(AuthRepositoryImpl(NetworkClient()));

    await tester.pumpWidget(MyApp(authProvider: authProvider));

    // 기본 MaterialApp 렌더링 확인
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
