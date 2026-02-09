import 'package:flutter/material.dart';
import 'presensi_detail.dart';

class PresensiPertemuanPage extends StatelessWidget {
  final String subjectName;

  const PresensiPertemuanPage({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF050542);
    const Color accentColor = Color(0xFFFFA726);

    // Dummy Data Pertemuan
    final List<Map<String, dynamic>> meetings = [
      {'title': 'Pertemuan 16', 'date': '20 Jan 2026', 'status': 'Presensi Dibuka', 'isOpen': true},
      {'title': 'Pertemuan 15', 'date': '13 Jan 2026', 'status': 'Hadir', 'isOpen': false},
      {'title': 'Pertemuan 14', 'date': '06 Jan 2026', 'status': 'Hadir', 'isOpen': false},
      {'title': 'Pertemuan 13', 'date': '30 Des 2025', 'status': 'Sakit', 'isOpen': false},
      {'title': 'Pertemuan 12', 'date': '23 Des 2025', 'status': 'Izin', 'isOpen': false},
      {'title': 'Pertemuan 11', 'date': '16 Des 2025', 'status': 'Alpa', 'isOpen': false},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Daftar Pertemuan", style: TextStyle(fontWeight: FontWeight.bold)),
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
            height: 250,
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
            top: 100,
            left: -30,
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
              SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + 10),

              // INFO MATA KULIAH (Floating Card)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.class_rounded, color: primaryColor, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            "Mata Kuliah",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        subjectName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Progress Bar Kecil (Visualisasi Kehadiran)
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: 0.8, // Dummy value
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "80%",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // LABEL TIMELINE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "Riwayat Pertemuan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.sort_rounded, color: Colors.grey[400]),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // LIST PERTEMUAN
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  itemCount: meetings.length,
                  itemBuilder: (context, index) {
                    final item = meetings[index];
                    return _buildMeetingCard(context, item, index, meetings.length);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingCard(BuildContext context, Map<String, dynamic> item, int index, int total) {
    final bool isOpen = item['isOpen'];
    final String status = item['status'];

    // Menentukan Warna Status
    Color statusColor;
    Color bgColor;
    
    if (isOpen) {
      statusColor = Colors.blue[700]!;
      bgColor = Colors.blue[50]!;
    } else if (status == 'Hadir') {
      statusColor = Colors.green[700]!;
      bgColor = Colors.green[50]!;
    } else if (status == 'Sakit' || status == 'Izin') {
      statusColor = Colors.orange[800]!;
      bgColor = Colors.orange[50]!;
    } else {
      statusColor = Colors.red[700]!;
      bgColor = Colors.red[50]!;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // Jika Open, beri border biru dan shadow lebih besar
        border: isOpen ? Border.all(color: Colors.blue.withOpacity(0.5), width: 1.5) : null,
        boxShadow: [
          BoxShadow(
            color: isOpen ? Colors.blue.withOpacity(0.15) : Colors.black.withOpacity(0.05),
            blurRadius: isOpen ? 15 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isOpen
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PresensiDetailPage(
                        subjectName: subjectName,
                        meetingTitle: item['title'],
                        date: item['date'],
                      ),
                    ),
                  );
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Meeting Number Badge
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF050542).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "${total - index}",
                      style: const TextStyle(
                        color: Color(0xFF050542),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),

                // Title & Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            item['date'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // Indikator Titik kecil jika open
                      if (isOpen)
                        Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Panah (Hanya jika Open)
                if (isOpen) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios_rounded, size: 14, color: statusColor),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}