import 'package:flutter/material.dart';
import 'dart:async';

class DevNotePage extends StatefulWidget {
  const DevNotePage({super.key});

  @override
  State<DevNotePage> createState() => _DevNotePageState();
}

class _DevNotePageState extends State<DevNotePage> {
  // --- CAROUSEL LOGIC ---
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Data Dummy Gambar
  final List<String> _images = [
    'https://picsum.photos/id/48/800/400', 
    'https://picsum.photos/id/180/800/400', 
    'https://picsum.photos/id/60/800/400', 
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF050542);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Profil DTI UNP",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION 1: CAROUSEL GAMBAR ---
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        _images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                           return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, color: Colors.grey),
                          );
                        },
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_images.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentPage == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color(0xFFFFA726)
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // --- SECTION 2: KONTEN ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TENTANG DTI
                  _buildSectionTitle("Tentang DTI"),
                  const SizedBox(height: 10),
                  const Text(
                    "Unit Pelaksana Teknis Teknologi Informasi dan Komunikasi (UPT TIK) Universitas Negeri Padang, atau yang lebih dikenal dengan DTI, adalah unit yang bertanggung jawab dalam pengembangan, pengelolaan, dan pelayanan infrastruktur serta sistem informasi di lingkungan Universitas Negeri Padang.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                  ),

                  const SizedBox(height: 30),

                  // VISI
                  _buildSectionTitle("Visi"),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF050542).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF050542).withOpacity(0.1)),
                    ),
                    child: const Text(
                      "\"Menjadi pusat layanan teknologi informasi yang unggul dan inovatif dalam mendukung penyelenggaraan Tridharma Perguruan Tinggi di Universitas Negeri Padang.\"",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // MISI
                  _buildSectionTitle("Misi"),
                  const SizedBox(height: 10),
                  _buildListItem("Mengembangkan infrastruktur jaringan dan pusat data yang handal dan aman."),
                  _buildListItem("Membangun sistem informasi terintegrasi untuk efisiensi manajemen akademik."),
                  _buildListItem("Meningkatkan kompetensi SDM dalam pemanfaatan teknologi informasi."),
                  _buildListItem("Memberikan layanan prima di bidang TIK kepada sivitas akademika."),
                  
                  // --- BAGIAN BARU: TUJUAN ---
                  const SizedBox(height: 30),

                  _buildSectionTitle("Tujuan"),
                  const SizedBox(height: 10),
                  _buildListItem("Terwujudnya layanan TIK yang prima untuk mendukung kegiatan akademik dan administrasi."),
                  _buildListItem("Terciptanya ekosistem digital kampus yang terintegrasi, aman, dan user-friendly."),
                  _buildListItem("Meningkatnya kepuasan pengguna (mahasiswa, dosen, tendik) terhadap layanan TIK."),
                  _buildListItem("Tersedianya data dan informasi yang akurat dan real-time untuk pengambilan keputusan pimpinan."),

                  const SizedBox(height: 40),

                  // Footer Contact
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Hubungi Kami:",
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "helpdesk@unp.ac.id",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget Judul
  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF050542),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: const Color(0xFFFFA726),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  // Helper Widget List Item (Dipakai untuk Misi & Tujuan)
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.check_circle, size: 16, color: Color(0xFFFFA726)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}