import 'package:flutter/material.dart';

// Pastikan import file page Anda ada di sini
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

  // 1. Menambahkan Halaman News ke dalam list
  final List<Widget> _pages = const [
    HomePage(),
    NewsPage(), // Placeholder class ada di bawah kode ini
    EOfficePage(),
    AgendaPage(),
    ProfilePage(),
  ];

  // 2. Menambahkan Data Menu News (Posisi setelah Home)
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.home_rounded, 'label': 'Home'},
    {'icon': Icons.newspaper_rounded, 'label': 'News'}, // Menu Baru
    {'icon': Icons.chat_bubble_rounded, 'label': 'E-Office'},
    {'icon': Icons.calendar_month_rounded, 'label': 'Agenda'},
    {'icon': Icons.person_rounded, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Membiarkan body memanjang ke belakang navbar
      body: _pages[_currentIndex],

      bottomNavigationBar: SafeArea(
        child: Container(
          // Mengurangi tinggi sedikit agar lebih proporsional
          height: 70,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30), // Lebih bulat
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF050542).withOpacity(0.15),
                blurRadius: 25,
                offset: const Offset(0, 10),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _menuItems.length,
                (index) => _buildAnimatedNavItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedNavItem(int index) {
    final bool isSelected = _currentIndex == index;
    
    // Warna tema diambil dari kode Anda (Deep Blue)
    const Color activeColor = Color(0xFF050542);

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        // Durasi animasi diperhalus
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutQuart,
        // Container melebar jika dipilih (responsive width)
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 10, 
          vertical: 10
        ),
        decoration: BoxDecoration(
          // Jika dipilih: Background Biru Tua. Jika tidak: Transparan
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Icon(
              _menuItems[index]['icon'],
              // Jika dipilih icon jadi putih, jika tidak abu-abu
              color: isSelected ? Colors.white : Colors.grey.shade400,
              size: 24,
            ),
            
            // Teks Label dengan animasi lebar (Sliding Text)
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuart,
              child: SizedBox(
                width: isSelected ? null : 0, // Lebar 0 jika tidak dipilih
                child: Padding(
                  padding: isSelected 
                      ? const EdgeInsets.only(left: 8) 
                      : EdgeInsets.zero,
                  child: Text(
                    _menuItems[index]['label'],
                    style: const TextStyle(
                      color: Colors.white, // Teks putih agar kontras
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
