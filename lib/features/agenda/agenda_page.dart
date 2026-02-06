import 'package:flutter/material.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna Tema
    const Color primaryColor = Color(0xFF050542);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Agenda',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar diperbesar dan tanpa background Container
              Image.asset(
                'lib/assets/images/error.png',
                width: 190, // Ukuran diperbesar (sebelumnya 180)
                fit: BoxFit.contain,
              ),
              
              const SizedBox(height: 8),
              
              // Judul Utama
              const Text(
                'Fitur Belum Tersedia',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Deskripsi
              Text(
                'Mohon maaf, halaman Agenda saat ini sedang dalam proses pengembangan.\nSilakan cek kembali nanti.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              
              // Tombol kembali sudah dihapus sesuai permintaan
            ],
          ),
        ),
      ),
    );
  }
}