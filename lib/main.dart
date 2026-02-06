import 'package:flutter/material.dart';

// Splash
import 'features/splash/splash_page.dart';

// Login
import 'features/auth/login_page.dart';

// Main (Bottom Navigation)
import 'features/navigation/main_page.dart';

void main() {
  runApp(const MyUNPCloneApp());
}

class MyUNPCloneApp extends StatelessWidget {
  const MyUNPCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyUNP Clone',

      // halaman awal aplikasi
      initialRoute: '/',

      // routing aplikasi
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}
