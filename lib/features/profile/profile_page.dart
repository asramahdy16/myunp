import 'package:flutter/material.dart';
import '../about/about_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // --- FUNGSI MENAMPILKAN DIALOG QR ---
  void _showQrDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "QR Code Saya",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF050542),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Scan untuk melihat profil akademik",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'lib/assets/images/qr_profile.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF050542),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text("Tutup"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definisi Warna
    const Color amberColor = Color(0xFFFFA726);
    const Color textDarkColor = Color(0xFF050542);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- BAGIAN ATAS (Header Gradient Modern) ---
            Container(
              width: double.infinity,
              // UPDATE: Padding bawah diperbesar agar background biru lebih panjang
              // dan card turun ke bawah tidak menutupi teks
              padding: const EdgeInsets.only(bottom: 80), 
              
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF050542),
                    Color(0xFF0A0F6C),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  // Dekorasi Lingkaran Abstrak
                  Positioned(
                    top: -50,
                    right: -50,
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
                    top: 100,
                    left: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: amberColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // KONTEN PROFILE (Foreground)
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                      child: Column(
                        children: [
                          // Header Icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => _showQrDialog(context),
                                icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 28),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AboutPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.more_horiz, color: Colors.white, size: 28),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          // Foto Profil
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              image: const DecorationImage(
                                image: AssetImage('lib/assets/images/profile.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Tombol Ganti Photo
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                            decoration: BoxDecoration(
                              color: amberColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            ),
                            child: const Text(
                              "GANTI PHOTO",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Identitas
                          const Text(
                            "Asra Mahdy Hayun",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "22076030",
                            style: TextStyle(
                              color: amberColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Prodi Pendidikan Teknik Informatika",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- BAGIAN KARTU INFORMASI ---
            Transform.translate(
              offset: const Offset(0, -60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildProfileItem(
                        icon: Icons.info_outline_rounded,
                        title: "App Version",
                        value: "2.0.10",
                        textColor: textDarkColor,
                      ),
                      const SizedBox(height: 24),
                      _buildProfileItem(
                        icon: Icons.dns_rounded,
                        title: "Storage Status",
                        value: "0.00 KB",
                        textColor: textDarkColor,
                      ),
                      const SizedBox(height: 24),
                      _buildProfileItem(
                        icon: Icons.history_rounded,
                        title: "Last Login",
                        value: "6 Januari 2026",
                        textColor: textDarkColor,
                      ),
                      const SizedBox(height: 24),
                      _buildProfileItem(
                        icon: Icons.chat_bubble_outline_rounded,
                        title: "WhatsApp",
                        value: "08123456789",
                        textColor: textDarkColor,
                        isVerified: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGET ---
  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
    required Color textColor,
    bool isVerified = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: textColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: textColor, size: 24),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isVerified) ...[
          const SizedBox(width: 4),
          const Icon(Icons.verified, color: Colors.blue, size: 16),
        ],
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}