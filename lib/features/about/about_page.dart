import 'package:flutter/material.dart';
import 'dev_note_page.dart'; 
import '../web/web_page.dart'; // <--- Pastikan import ini ada

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi Warna
    const Color amberColor = Color(0xFFFFA726);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- BAGIAN ATAS (Header Gradient Modern) ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 50), // Ruang untuk overlap kartu
              // Clip.hardEdge memastikan ornamen lingkaran tidak keluar dari border radius
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
                  // Dekorasi Lingkaran Abstrak (Background)
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

                  // KONTEN FOREGROUND
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                      child: Column(
                        children: [
                          // 1. Custom AppBar
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              const Expanded(
                                child: Text(
                                  "About MyUNP",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40), // Dummy spacing
                            ],
                          ),
                          
                          const SizedBox(height: 30),

                          // 2. Logo UNP
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'lib/assets/images/logo_unp.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // 3. Teks Info
                          const Text(
                            "©️ DTI UNP 2026",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Version 2.0.1-beta",
                              style: TextStyle(
                                fontSize: 12,
                                color: amberColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20), 
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- BAGIAN BAWAH (Kartu Putih Overlap) ---
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      // Tombol Developer Note
                      _buildMenuItem(
                        icon: Icons.note_alt_outlined,
                        text: "Developer Note",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DevNotePage()),
                          );
                        },
                      ),
                      
                      // --- UPDATE: Navigasi Help & Contact ---
                      _buildMenuItem(
                        icon: Icons.help_outline_rounded,
                        text: "Help & Contact",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WebPage(
                                title: 'Help & Contact',
                                url: 'https://dti.unp.ac.id/helpdesk/login',
                              ),
                            ),
                          );
                        },
                      ),

                      // --- UPDATE: Navigasi About UNP ---
                      _buildMenuItem(
                        icon: Icons.info_outline_rounded,
                        text: "About UNP",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WebPage(
                                title: 'About UNP',
                                url: 'https://unp.ac.id/pages/tentang_sambutan_rektor/',
                              ),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 30),

                      // Tombol Logout
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                             ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Logging out...")),
                              );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFEBEE),
                            foregroundColor: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout_rounded),
                              SizedBox(width: 10),
                              Text(
                                "Logout",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon, 
    required String text, 
    required VoidCallback onTap
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFEFF3F8), width: 1.5),
        ),
        tileColor: Colors.white,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF050542).withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF050542), size: 22),
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF050542),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
        ),
      ),
    );
  }
}