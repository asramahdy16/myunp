import 'package:flutter/material.dart';
import 'news_page.dart'; // Pastikan mengimport file NewsPage agar model NewsItem terbaca

class NewsViewPage extends StatelessWidget {
  final NewsItem news;

  const NewsViewPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    // Menggunakan dummy content panjang untuk simulasi artikel penuh
    final String fullContent = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

${news.snippet}

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.

Di masa depan, fitur ini akan terintegrasi langsung dengan database backend kantor, sehingga setiap pengumuman resmi, surat edaran, atau berita kegiatan dapat diakses secara real-time oleh seluruh pegawai.

Terima kasih telah menggunakan aplikasi E-Office ini.
    """;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 1. AppBar dengan Gambar Besar (SliverAppBar)
          SliverAppBar(
            expandedHeight: 300,
            pinned: true, // AppBar tetap terlihat saat di-scroll
            backgroundColor: const Color(0xFF050542),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: news.title, // Tag harus sama dengan di halaman List agar animasi jalan
                child: Image.network(
                  news.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey, child: const Icon(Icons.error));
                  },
                ),
              ),
            ),
          ),

          // 2. Konten Berita
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              // Menggeser container sedikit ke atas agar menutupi bagian bawah gambar
              transform: Matrix4.translationValues(0, -20, 0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Garis Indikator Kecil (Pemanis)
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),

                  // Judul Berita
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF050542),
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Metadata (Tanggal & Views)
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Text(
                        news.date,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.visibility_rounded, size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Text(
                        '${news.views} Views',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),

                  // Isi Berita
                  Text(
                    fullContent,
                    textAlign: TextAlign.justify, // Teks rata kanan kiri
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.8, // Jarak antar baris agar nyaman dibaca
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}