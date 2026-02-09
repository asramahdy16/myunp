import 'package:flutter/material.dart';
import 'dart:math';
import '../web/web_page.dart';

// Import halaman-halaman fitur
import '../news/news_page.dart';
import '../news/news_view_page.dart';
import '../krs/krs_page.dart';
import '../wifi/wifi_page.dart';
import '../transkrip/transkrip_page.dart';
import '../presensi/presensi_page.dart';

// --- 1. CONFIGURATION ---
class AppColors {
  static const Color primary = Color(0xFF050542);
  static const Color sectionBg = Color(0xFFF8F9FD);
  static const Color accent = Colors.amber;
  static const Color textPrimary = Color(0xFF050542);
  static const Color textSecondary = Colors.grey;
  static const Color border = Color(0xFFEFF3F8);
  static const Color white = Colors.white;
}

// --- 2. DATA MODEL ---
class MenuData {
  final String title;
  final String assetName;
  final String? url;
  final VoidCallback? onTap;

  MenuData({
    required this.title,
    required this.assetName,
    this.url,
    this.onTap,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // --- MENU AKADEMIK ---
  List<MenuData> _getAcademicMenus(BuildContext context) => [
        MenuData(title: 'Evaluasi', assetName: 'lib/assets/icons/evaluasi.png'),
        MenuData(title: 'Foto Wisuda', assetName: 'lib/assets/icons/foto_wisuda.png'),
        
        // KRS Online
        MenuData(
          title: 'KRS Online',
          assetName: 'lib/assets/icons/krs.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KrsPage()),
            );
          },
        ),

        // Presensi
        MenuData(
          title: 'Presensi',
          assetName: 'lib/assets/icons/presensi.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PresensiPage()),
            );
          },
        ),

        // Wifi ID
        MenuData(
          title: 'Password @wifi.id',
          assetName: 'lib/assets/icons/wifi_id.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WifiPage()),
            );
          },
        ),

        // Transkrip
        MenuData(
          title: 'Transkrip',
          assetName: 'lib/assets/icons/historis.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TranskripPage()),
            );
          },
        ),
      ];

  // --- MENU WEBSITE ---
  List<MenuData> get _websiteMenus => [
        MenuData(
            title: 'Portal',
            assetName: 'lib/assets/images/logo_unp.png',
            url: 'https://portal.unp.ac.id/'),
        MenuData(
            title: 'SMILE',
            assetName: 'lib/assets/images/logo_unp.png',
            url: 'https://smile.unp.ac.id/'),
        MenuData(
            title: 'Rumah Gadang',
            assetName: 'lib/assets/images/logo_unp.png',
            url: 'https://rumah-gadang.unp.ac.id/'),
      ];

  // --- BERITA TERBARU ---
  List<NewsItem> get _latestNews => [
        NewsItem(
          title: 'Peluncuran Fitur Baru E-Office',
          snippet: 'Sistem E-Office kini dilengkapi tanda tangan digital.',
          date: '20 Jan',
          views: 1240,
          imageUrl: 'https://picsum.photos/id/1/300/200',
        ),
        NewsItem(
          title: 'Workshop Flutter Tim IT',
          snippet: 'Pelatihan intensif pengembangan aplikasi mobile.',
          date: '15 Jan',
          views: 2300,
          imageUrl: 'https://picsum.photos/id/180/300/200',
        ),
        NewsItem(
          title: 'Libur Nasional 2026',
          snippet: 'Jadwal libur nasional dan cuti bersama.',
          date: '10 Jan',
          views: 5600,
          imageUrl: 'https://picsum.photos/id/13/300/200',
        ),
      ];

  // --- HELPER NAVIGASI ---
  void _handleNavigation(BuildContext context, MenuData menu) {
    if (menu.onTap != null) {
      menu.onTap!();
    } else if (menu.url != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebPage(title: menu.title, url: menu.url!),
        ),
      );
    }
  }

  // --- WIDGETS ---

  Widget _buildNewsCard(BuildContext context, NewsItem news) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsViewPage(news: news)),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: news.title,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    news.imageUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      height: 140,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Info Terbaru',
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      news.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded,
                            size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          news.date,
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[600]),
                        ),
                        const Spacer(),
                        Icon(Icons.visibility_rounded,
                            size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          '${news.views}',
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[600]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLatestNewsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Berita Terbaru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Update Hari Ini',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 270,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _latestNews.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildNewsCard(context, _latestNews[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuData menu) {
    return GestureDetector(
      onTap: () => _handleNavigation(context, menu),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: Image.asset(menu.assetName, fit: BoxFit.contain),
            ),
            const SizedBox(height: 10),
            Text(
              menu.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: 0.3,
                height: 1.1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(
      BuildContext context, String title, List<MenuData> menus) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
              const Text(
                'Lihat Semua',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.sectionBg,
              borderRadius: BorderRadius.circular(24),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                return _buildMenuItem(context, menus[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMascotBanner() {
    const double totalHeight = 160;
    const double cardMarginTop = 20;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: totalHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: totalHeight - cardMarginTop,
            margin: const EdgeInsets.only(top: cardMarginTop),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF050542), Color(0xFF0A0F6C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 12, bottom: 12, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Selamat Datang!",
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Flexible(
                          child: Text(
                            "Tetap semangat menjalani perkuliahan hari ini!",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Cek Berita >",
                            style:
                                TextStyle(color: AppColors.white, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
          Positioned(
            right: -10,
            bottom: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 0,
            child: Image.asset(
              'lib/assets/images/mascot.png',
              fit: BoxFit.fitHeight,
              height: 155,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCenter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pusat Bantuan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ]),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.sectionBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset('lib/assets/icons/pengaduan.png'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Layanan Pengaduan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Punya masalah akademik? Laporkan disini.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: Colors.grey[400]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HomeHeaderDelegate(minHeight: 100.0, maxHeight: 180.0),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildMascotBanner(),

                const SizedBox(height: 25),
                _buildLatestNewsSection(context),

                const SizedBox(height: 25),
                _buildMenuSection(context, 'Layanan Akademik', _getAcademicMenus(context)),
                
                const SizedBox(height: 30),
                _buildMenuSection(context, 'Website Kampus', _websiteMenus),
                const SizedBox(height: 30),
                _buildHelpCenter(),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- DELEGATE HEADER (UPDATED WITH GRADIENT & SHAPES) ---
class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  HomeHeaderDelegate({required this.minHeight, required this.maxHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double shrinkPercentage =
        min(1, shrinkOffset / (maxHeight - minHeight));
    
    // Perhitungan Ukuran Dinamis
    final double logoSize = (50 * (1 - shrinkPercentage)) + (36 * shrinkPercentage);
    final double nameFontSize = (18 * (1 - shrinkPercentage)) + (16 * shrinkPercentage);
    final double fadeOpacity = (1 - (shrinkPercentage * 2)).clamp(0.0, 1.0);

    return Container(
      // Clip.hardEdge agar dekorasi tidak keluar dari border radius bawah
      clipBehavior: Clip.hardEdge, 
      decoration: const BoxDecoration(
        // 1. UPDATE: GRADIENT BACKGROUND
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF050542),
            Color(0xFF0A0F6C),
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
        ]
      ),
      child: Stack(
        children: [
          // 2. UPDATE: DEKORASI ORNAMEN LINGKARAN
          // Lingkaran Kanan Atas
          Positioned(
            top: -50,
            right: -30,
            child: Opacity(
              opacity: (1 - shrinkPercentage).clamp(0.0, 1.0), // Hilang saat discroll
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          
          // Lingkaran Kiri Bawah
          Positioned(
            bottom: -40,
            left: -20,
            child: Opacity(
              opacity: (1 - shrinkPercentage).clamp(0.0, 1.0),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // 3. KONTEN UTAMA (Foreground)
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Profil
                  Container(
                    width: logoSize,
                    height: logoSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(
                          color: AppColors.accent.withOpacity(0.8), width: 2),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: ClipOval(
                      child: Image.asset('lib/assets/images/logo_unp.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Teks Identitas
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Asra Mahdy Hayun',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: nameFontSize,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        // Subtitle (Hilang saat discroll)
                        if (fadeOpacity > 0) ...[
                          Opacity(
                            opacity: fadeOpacity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                        color: AppColors.accent,
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 6),
                                  const Expanded(
                                    child: Text(
                                      'Prodi Pendidikan Teknik Informatika',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                  
                  // Ikon Notifikasi & QR
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _headerIcon(Icons.qr_code_scanner_rounded),
                      const SizedBox(width: 12),
                      _headerIcon(Icons.notifications_none_rounded),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: AppColors.white, size: 22),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) => true;
}