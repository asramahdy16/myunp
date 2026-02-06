import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  
  // Animations
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _slideUp;
  late Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // 1. Animasi Logo
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // 2. Animasi Teks (Naik sedikit)
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
       Navigator.pushReplacementNamed(context, '/login'); 
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF6C63FF); 

    return Scaffold(
      // Scaffold background putih sebagai dasar
      backgroundColor: Colors.white, 
      body: Stack(
        fit: StackFit.expand, // Memastikan stack mengisi seluruh layar
        children: [
          /// 1. BACKGROUND GRADIENT (Full Screen)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xFFF5F7FA),
                ],
              ),
            ),
          ),

          /// 2. DEKORASI (Opsional - Pojok Kanan Atas)
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// 3. KONTEN UTAMA (LOGO & TEKS) - BENAR-BENAR DI TENGAH (CENTER)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Penting: Agar Column hanya setinggi kontennya
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO
                FadeTransition(
                  opacity: _logoOpacity,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      padding: const EdgeInsets.all(15), // Padding agar shadow tidak terpotong
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'lib/assets/images/logo_unp.png',
                        width: 130, 
                        height: 130,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 5), // Jarak antara logo dan teks

                // JUDUL APLIKASI
                FadeTransition(
                  opacity: _textOpacity,
                  child: SlideTransition(
                    position: _slideUp,
                    child: Column(
                      children: [
                        const Text(
                          "MyUNP",
                          style: TextStyle(
                            fontSize: 36, // Sedikit diperbesar
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Ver 2.0.1-beta",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // LOADING SPINNER
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 4. VERSION (DI BAGIAN BAWAH LAYAR)
          Positioned(
            left: 0,
            right: 0,
            bottom: 30, // Jarak dari bawah layar
            child: SafeArea( // Agar aman di HP berponi/gesture bar
              child: FadeTransition(
                opacity: _textOpacity,
                child: const Center(
                  child: Text(
                    '©️ DTI UNP 2026',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}