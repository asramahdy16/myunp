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
  static const Color primaryColor = Color(0xFF050542);

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'E-News',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // --- Search Bar Section ---
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => _runFilter(value),
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'Cari berita...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // --- List Berita ---
          Expanded(
            child: _foundNews.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 16, bottom: 100),
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
                        // --- UPDATE BAGIAN INI (Mengganti Icon dengan Asset Image) ---
                        Opacity(
                          opacity: 1, // Sedikit transparan agar menyatu dengan background
                          child: Image.asset(
                            'lib/assets/images/error.png', // Sesuai permintaan
                            width: 150, // Ukuran disesuaikan
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
    );
  }

  // 4. Widget Item Berita (Card)
  Widget _buildNewsCard(NewsItem news) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
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
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      news.imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90,
                          height: 90,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14),
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
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        news.snippet,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded,
                              size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            news.date,
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[500]),
                          ),
                          const Spacer(),
                          Icon(Icons.visibility_rounded,
                              size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            '${news.views}',
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[500]),
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