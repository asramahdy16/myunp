import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  // Animations
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _contentFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 1. Animasi Logo (Membal / Elastic)
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    // 2. Animasi Fade
    _contentFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    // 3. Animasi Slide Teks
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    // Navigasi ke halaman Login setelah selesai
    Timer(const Duration(seconds: 4), () {
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
    // Definisi Warna Tema Cerah
    const Color primaryColor = Color(0xFF050542);
    const Color accentColor = Color(0xFFFFA726);
    const Color bgColor = Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // --- 1. DEKORASI BACKGROUND (Abstrak) ---
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.03),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // --- 2. KONTEN UTAMA (CENTER) ---
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO ANIMATION
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Container(
                    width: 170,
                    height: 170,
                    // HAPUS PADDING DI SINI
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.15), // Shadow sedikit lebih tegas
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    // Gunakan ClipOval agar gambar terpotong mengikuti bentuk lingkaran
                    child: ClipOval(
                      child: Image.asset(
                        'lib/assets/images/logo_unp.png',
                        fit: BoxFit.cover, // Gambar memenuhi container (Full)
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // TEKS JUDUL & LOADING
                FadeTransition(
                  opacity: _contentFadeAnimation,
                  child: SlideTransition(
                    position: _textSlideAnimation,
                    child: Column(
                      children: [
                        const Text(
                          "MyUNP",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: primaryColor,
                            letterSpacing: 1.5,
                            fontFamily: 'Roboto', 
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "v2.1.9-beta",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 60),

                        // Loading Indicator
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: primaryColor,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- 3. FOOTER ---
          Positioned(
            left: 0, 
            right: 0,
            bottom: 30,
            child: FadeTransition(
              opacity: _contentFadeAnimation,
              child: Column(
                children: [
                  Text(
                    'Developed by',
                    style: TextStyle(color: Colors.grey[400], fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'DTI UNP © 2026',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}