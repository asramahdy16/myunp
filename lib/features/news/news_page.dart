import 'package:flutter/material.dart';
import '../news/news_view_page.dart';

// 1. Model Data Sederhana untuk Berita
class NewsItem {
  final String title;
  final String snippet;
  final String date;
  final int views;
  final String imageUrl;

  NewsItem({
    required this.title,
    required this.snippet,
    required this.date,
    required this.views,
    required this.imageUrl,
  });
}

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // Warna Tema
  final Color primaryColor = const Color(0xFF050542);
  final Color accentColor = const Color(0xFFFFA726);

  // 2. Dummy Data Berita
  final List<NewsItem> _allNews = [
    NewsItem(
      title: 'Peluncuran Fitur Baru E-Office',
      snippet: 'Sistem E-Office kini dilengkapi dengan tanda tangan digital dan disposisi otomatis untuk mempercepat birokrasi.',
      date: '20 Jan 2026',
      views: 1240,
      imageUrl: 'https://picsum.photos/id/1/200/200',
    ),
    NewsItem(
      title: 'Rapat Evaluasi Kinerja Triwulan I',
      snippet: 'Manajemen mengadakan rapat evaluasi untuk membahas pencapaian target dan strategi di kuartal berikutnya.',
      date: '18 Jan 2026',
      views: 856,
      imageUrl: 'https://picsum.photos/id/20/200/200',
    ),
    NewsItem(
      title: 'Workshop Flutter untuk Tim IT',
      snippet: 'Tim pengembang mengikuti pelatihan intensif pengembangan aplikasi mobile menggunakan Flutter terbaru.',
      date: '15 Jan 2026',
      views: 2300,
      imageUrl: 'https://picsum.photos/id/180/200/200',
    ),
    NewsItem(
      title: 'Libur Nasional & Cuti Bersama 2026',
      snippet: 'Pengumuman resmi mengenai jadwal libur nasional dan prosedur pengajuan cuti bagi karyawan.',
      date: '10 Jan 2026',
      views: 5600,
      imageUrl: 'https://picsum.photos/id/13/200/200',
    ),
    NewsItem(
      title: 'Maintenance Server Akhir Pekan',
      snippet: 'Diberitahukan akan ada pemeliharaan server pada hari Sabtu pukul 22.00 WIB hingga Minggu pagi.',
      date: '05 Jan 2026',
      views: 450,
      imageUrl: 'https://picsum.photos/id/60/200/200',
    ),
  ];

  // List untuk menampung hasil pencarian
  List<NewsItem> _foundNews = [];

  @override
  void initState() {
    super.initState();
    _foundNews = _allNews;
  }

  // 3. Fungsi Pencarian
  void _runFilter(String enteredKeyword) {
    List<NewsItem> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allNews;
    } else {
      results = _allNews
          .where((news) =>
              news.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundNews = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Background body sedikit abu
      extendBodyBehindAppBar: true, // Header menyatu dengan status bar
      appBar: AppBar(
        title: const Text(
          'E-News',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Transparan karena ada background gradient
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // --- 1. HEADER GRADIENT BACKGROUND ---
          Container(
            height: 230, // Tinggi header background
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF050542),
                  const Color(0xFF0A0F6C),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),

          // --- 2. DEKORASI ABSTRAK (Circles) ---
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // --- 3. KONTEN UTAMA ---
          Column(
            children: [
              // Spacer untuk AppBar dan Status Bar
              SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + 10),

              // --- SEARCH BAR (Floating Style) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: 'Cari berita...',
                      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                      prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF050542)),
                      filled: true,
                      fillColor: Colors.transparent, // Background handle by Container
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- LIST BERITA ---
              Expanded(
                child: _foundNews.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.only(top: 0, bottom: 100),
                        itemCount: _foundNews.length,
                        itemBuilder: (context, index) {
                          final news = _foundNews[index];
                          return _buildNewsCard(news);
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: 0.8,
                              child: Image.asset(
                                'lib/assets/images/error.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Berita tidak ditemukan',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 4. Widget Item Berita (Card)
  Widget _buildNewsCard(NewsItem news) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10), // Margin kiri kanan disamakan dengan search bar
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              MaterialPageRoute(
                builder: (context) => NewsViewPage(news: news),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: news.title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      news.imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90,
                          height: 90,
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported_rounded, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF050542),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        news.snippet,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded, size: 12, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            news.date,
                            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                          ),
                          const Spacer(),
                          Icon(Icons.visibility_rounded, size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            '${news.views}',
                            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}