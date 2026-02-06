import 'package:flutter/material.dart';

// Model Data KRS
class KrsItem {
  final String subjectName;
  final String code;
  final int sKs;
  final String day;
  final String time;
  final String room;
  final String lecturer;

  KrsItem({
    required this.subjectName,
    required this.code,
    required this.sKs,
    required this.day,
    required this.time,
    required this.room,
    required this.lecturer,
  });
}

class KrsPage extends StatelessWidget {
  const KrsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF050542);
    const Color accentColor = Color(0xFFFFA726);
    const Color bgColor = Color(0xFFF5F7FA); // Abu-abu sangat muda

    // Dummy Data Mata Kuliah
    final List<KrsItem> krsList = [
      KrsItem(
        subjectName: "Pemrograman Perangkat Bergerak",
        code: "TIF1234",
        sKs: 3,
        day: "Senin",
        time: "07:00 - 09:40",
        room: "Lab Komputer 3 (Gedung H)",
        lecturer: "Dr. Asra Mahdy, S.T., M.Kom.",
      ),
      KrsItem(
        subjectName: "Keamanan Jaringan & Informasi",
        code: "TIF2210",
        sKs: 2,
        day: "Selasa",
        time: "10:00 - 11:40",
        room: "Ruang Teori 204 (Gedung F)",
        lecturer: "Budi Santoso, M.Kom.",
      ),
      KrsItem(
        subjectName: "Metodologi Penelitian",
        code: "TIF3301",
        sKs: 2,
        day: "Rabu",
        time: "13:20 - 15:00",
        room: "Ruang Seminar (Gedung Utama)",
        lecturer: "Prof. Dr. Siti Aminah",
      ),
      KrsItem(
        subjectName: "Kecerdasan Buatan",
        code: "TIF1109",
        sKs: 3,
        day: "Kamis",
        time: "08:00 - 10:30",
        room: "Lab Robotika",
        lecturer: "Rahmat Hidayat, Ph.D.",
      ),
      KrsItem(
        subjectName: "Technopreneurship",
        code: "UNP001",
        sKs: 2,
        day: "Jumat",
        time: "09:00 - 10:40",
        room: "Aula Fakultas Teknik",
        lecturer: "Tim Dosen UNP",
      ),
    ];

    // Hitung Total SKS
    final int totalSks = krsList.fold(0, (sum, item) => sum + item.sKs);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          "KRS Online",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          // --- HEADER INFO SKS (Desain Compact) ---
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Semester Jan-Jun 2026",
                      style: TextStyle(
                        color: Colors.white70, 
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Kartu Rencana Studi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                // Badge Total SKS
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accentColor.withOpacity(0.5)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Total SKS",
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                      Text(
                        "$totalSks",
                        style: const TextStyle(
                          color: accentColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // --- LIST MATA KULIAH ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: krsList.length,
              itemBuilder: (context, index) {
                final item = krsList[index];
                return _buildModernKrsCard(item, primaryColor, accentColor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernKrsCard(KrsItem item, Color primaryColor, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF050542).withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight( // Agar tinggi garis samping mengikuti konten
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. DECORATIVE STRIP (KIRI)
              Container(
                width: 6,
                color: accentColor, // Warna Amber sebagai penanda
              ),

              // 2. KONTEN KARTU
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Nama Matkul & Badge SKS
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.subjectName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: primaryColor,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.code,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Badge SKS
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${item.sKs} SKS",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      // Garis Pembatas Putus-putus (Optional, disini pakai solid tipis)
                      Divider(height: 1, color: Colors.grey[200]),
                      const SizedBox(height: 16),

                      // Info Detail (Grid Layout)
                      Row(
                        children: [
                          // Kolom Kiri: Waktu & Ruang
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildIconText(
                                  Icons.access_time_filled_rounded, 
                                  item.day, 
                                  item.time,
                                  Colors.blue[400]!
                                ),
                                const SizedBox(height: 12),
                                _buildIconText(
                                  Icons.location_on_rounded, 
                                  "Ruangan", 
                                  item.room,
                                  Colors.red[400]!
                                ),
                              ],
                            ),
                          ),
                          
                          // Garis Vertikal Kecil
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey[200],
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                          ),

                          // Kolom Kanan: Dosen
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person_rounded, size: 14, color: Colors.grey[400]),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Dosen",
                                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.lecturer,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget untuk Baris Ikon + Teks (Waktu & Lokasi)
  Widget _buildIconText(IconData icon, String label, String value, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: iconColor),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label, // Misal: Senin, atau "Ruangan"
                style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                value, // Misal: 07:00 - 09:40
                style: const TextStyle(
                  fontSize: 12, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}