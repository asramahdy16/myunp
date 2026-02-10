import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Import file page Anda
import '../home/home_page.dart';
import '../news/news_page.dart';
import '../eoffice/eoffice_page.dart';
import '../agenda/agenda_page.dart';
import '../profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Warna Tema
  final Color primaryColor = const Color(0xFF050542);
  final Color inactiveColor = Colors.grey.shade400;

  // Daftar Halaman
  final List<Widget> _pages = const [
    HomePage(), // Index 0
    NewsPage(), // Index 1
    EOfficePage(), // Index 2
    AgendaPage(), // Index 3
    ProfilePage(), // Index 4
  ];

  // Fungsi ganti halaman
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[50], // Background dasar aplikasi

      // 1. ANIMATED BODY SWITCHER (Transisi Halaman Halus)
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        // Efek transisi: Fade + Sedikit Zoom/Slide
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: Container(
          // Key penting agar AnimatedSwitcher tahu widget berubah
          key: ValueKey<int>(_currentIndex),
          child: _pages[_currentIndex],
        ),
      ),

      // 2. TOMBOL HOME (FAB) YANG LEBIH CANTIK
      floatingActionButton: SizedBox(
        height: 70, // Lebih besar
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () => _onItemTapped(0),
            backgroundColor: _currentIndex == 0 ? primaryColor : Colors.white,
            elevation: 8, // Shadow lebih dalam
            // Mencegah perubahan warna default Material 3
            // surfaceTintColor: _currentIndex == 0 ? primaryColor : Colors.white,
            shape: const CircleBorder(),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: SvgPicture.asset(
                'lib/assets/icons/home_unp.svg',

                // Key supaya AnimatedSwitcher tetap bekerja
                key: ValueKey<bool>(_currentIndex == 0),

                width: 30,
                height: 30,

                // Warna berubah sesuai aktif/tidak
                colorFilter: ColorFilter.mode(
                  _currentIndex == 0 ? Colors.white : primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 3. BOTTOM NAV BAR
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12.0, // Jarak notch lebih lebar agar elegan
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 20,
        shadowColor: Colors.black.withOpacity(0.4), // Shadow lebih lembut
        height: 75,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // KIRI
            _NavBarItem(
              icon: Icons.newspaper_rounded,
              label: "News",
              index: 1,
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              primaryColor: primaryColor,
            ),
            _NavBarItem(
              icon: Icons.chat_bubble_rounded,
              label: "E-Office",
              index: 2,
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              primaryColor: primaryColor,
            ),

            // SPACER TENGAH (Untuk FAB)
            const SizedBox(width: 60),

            // KANAN
            _NavBarItem(
              icon: Icons.calendar_month_rounded,
              label: "Agenda",
              index: 3,
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              primaryColor: primaryColor,
            ),
            _NavBarItem(
              icon: Icons.person_rounded,
              label: "Profile",
              index: 4,
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              primaryColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

// --- CUSTOM WIDGET UNTUK ICON NAVIGASI ---
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;
  final Color primaryColor;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentIndex == index;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animasi Icon (Naik sedikit & Berubah Warna)
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack, // Efek membal (bouncy)
              transform: Matrix4.translationValues(0, isSelected ? -2 : 0, 0),
              child: Icon(
                icon,
                color: isSelected ? primaryColor : Colors.grey.shade400,
                size: 26,
              ),
            ),

            const SizedBox(height: 4),

            // Animasi Text Label
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.grey.shade400,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                fontFamily: 'Nunito', // Opsional jika punya font custom
              ),
              child: Text(label),
            ),

            // Indikator Titik (Dot) di bawah label jika aktif
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: 4,
              width: isSelected ? 4 : 0, // Membesar dari 0 ke 4
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
