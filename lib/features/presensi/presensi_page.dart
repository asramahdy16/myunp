import 'package:flutter/material.dart';
import 'presensi_pertemuan.dart';
// import 'package:intl/intl.dart'; // Opsional: Jika ingin format tanggal otomatis

class PresensiPage extends StatelessWidget {
  const PresensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF050542);
    const Color accentColor = Color(0xFFFFA726);

    // Dummy Data Mata Kuliah
    final List<Map<String, String>> subjects = [
      {
        'name': 'Pemrograman Perangkat Bergerak',
        'code': 'TIF1234',
        'day': 'Senin',
        'time': '07:00 - 09:40',
        'lecturer': 'Dr. Asra Mahdy, S.T., M.Kom.'
      },
      {
        'name': 'Keamanan Jaringan & Informasi',
        'code': 'TIF2210',
        'day': 'Selasa',
        'time': '10:00 - 11:40',
        'lecturer': 'Budi Santoso, M.Kom.'
      },
      {
        'name': 'Kecerdasan Buatan',
        'code': 'TIF1109',
        'day': 'Kamis',
        'time': '08:00 - 10:30',
        'lecturer': 'Rahmat Hidayat, Ph.D.'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Presensi", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: Stack(
        children: [
          // --- 1. HEADER BACKGROUND GRADIENT ---
          Container(
            height: 260,
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

          // --- 2. DEKORASI ABSTRAK ---
          Positioned(
            top: -60,
            left: -40,
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
            right: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // --- 3. KONTEN UTAMA ---
          Column(
            children: [
              // Spacer untuk AppBar
              SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),

              // Header Text (Semester & Info)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Text(
                      "Semester Januari - Juni 2026",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Daftar Mata Kuliah",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Info Card Kecil (Ringkasan)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle_outline, color: accentColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            "${subjects.length} Kelas Diambil",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // LIST MATA KULIAH
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return _buildModernCourseCard(context, subject, primaryColor, accentColor);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernCourseCard(BuildContext context, Map<String, String> subject, Color primary, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                builder: (context) => PresensiPertemuanPage(subjectName: subject['name']!),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Kolom Jadwal (Kiri)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primary.withOpacity(0.1)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        subject['day']!.substring(0, 3).toUpperCase(), // SEN, SEL, KAM
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 2,
                        width: 20,
                        color: accent,
                      ),
                      const SizedBox(height: 4),
                      const Icon(Icons.access_time_filled, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),

                // Kolom Detail (Tengah)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: primary,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            subject['time']!,
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.person_rounded, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              subject['lecturer']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Panah (Kanan)
                const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}