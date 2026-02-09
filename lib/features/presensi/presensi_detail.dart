import 'package:flutter/material.dart';

class PresensiDetailPage extends StatefulWidget {
  final String subjectName;
  final String meetingTitle;
  final String date;

  const PresensiDetailPage({
    super.key,
    required this.subjectName,
    required this.meetingTitle,
    required this.date,
  });

  @override
  State<PresensiDetailPage> createState() => _PresensiDetailPageState();
}

class _PresensiDetailPageState extends State<PresensiDetailPage> {
  String? _selectedStatus; // Hadir, Sakit, Izin
  
  // Warna Tema
  final Color primaryColor = const Color(0xFF050542);
  final Color accentColor = const Color(0xFFFFA726);

  void _submitPresensi() {
    if (_selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih status kehadiran terlebih dahulu!")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Presensi $_selectedStatus Berhasil!"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Isi Kehadiran", style: TextStyle(fontWeight: FontWeight.bold)),
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
            height: 280, // Tinggi header
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
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // --- 3. KONTEN UTAMA ---
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + 20),

                // INFO PERTEMUAN (Floating Card)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Icon Header
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.class_rounded, color: primaryColor, size: 32),
                        ),
                        const SizedBox(height: 16),
                        
                        Text(
                          widget.subjectName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold, 
                            color: primaryColor
                          ),
                        ),
                        const SizedBox(height: 8),
                        Divider(color: Colors.grey[200]),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Text(
                              "${widget.meetingTitle} • ${widget.date}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Konfirmasi Kehadiran",
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold, 
                          color: primaryColor
                        ),
                      ),
                      const SizedBox(height: 16),

                      // --- PILIHAN STATUS (Grid Style) ---
                      _buildOptionCard("Hadir", Icons.check_circle_outline_rounded, Colors.green),
                      const SizedBox(height: 12),
                      _buildOptionCard("Sakit", Icons.local_hospital_outlined, Colors.orange),
                      const SizedBox(height: 12),
                      _buildOptionCard("Izin", Icons.mail_outline_rounded, Colors.blue),
                      
                      const SizedBox(height: 40),

                      // --- TOMBOL SUBMIT ---
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _submitPresensi,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shadowColor: primaryColor.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                          ),
                          child: const Text(
                            "Kirim Presensi",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String label, IconData icon, Color color) {
    bool isSelected = _selectedStatus == label;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[500],
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            
            // Label
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? color : Colors.grey[700],
              ),
            ),
            
            const Spacer(),
            
            // Radio Indicator
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: color, size: 24)
            else
              Icon(Icons.radio_button_unchecked_rounded, color: Colors.grey[300], size: 24),
          ],
        ),
      ),
    );
  }
}