import 'package:flutter/material.dart';
// 1. Tambahkan import ini
import 'package:intl/date_symbol_data_local.dart'; 

// Splash
import 'features/splash/splash_page.dart';

// Login
import 'features/auth/login_page.dart';

// Main (Bottom Navigation)
import 'features/navigation/main_page.dart';

// 2. Ubah void main() menjadi async
void main() async {
  // 3. Pastikan binding widget terinisialisasi sebelum menjalankan kode async
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Inisialisasi data format tanggal untuk Bahasa Indonesia
  // Pastikan string 'id_ID' sama dengan yang Anda pakai di DateFormat
  await initializeDateFormatting('id_ID', null); 

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