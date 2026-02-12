import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Warna Tema
  final Color primaryColor = const Color(0xFF050542);
  final Color bgColor = const Color(0xFFF8F9FD);

  // Dummy Data
  final List<Map<String, dynamic>> _allNotifications = [
    {
      "id": 1,
      "title": "Jadwal UAS Telah Terbit",
      "body": "Jadwal Ujian Akhir Semester Genap 2025/2026 sudah dapat diunduh di portal.",
      "time": "Baru saja",
      "type": "Akademik",
      "isRead": false,
    },
    {
      "id": 2,
      "title": "Pengingat: Pembayaran UKT",
      "body": "Batas akhir pembayaran UKT semester depan adalah tanggal 20 Februari 2026.",
      "time": "2 Jam yang lalu",
      "type": "Keuangan",
      "isRead": false,
    },
    {
      "id": 3,
      "title": "Workshop Flutter Development",
      "body": "Jangan lupa mengikuti workshop Flutter besok pagi di Ruang Sidang FT.",
      "time": "1 Hari yang lalu",
      "type": "Agenda",
      "isRead": true,
    },
    {
      "id": 4,
      "title": "Maintenance Server E-Learning",
      "body": "E-Learning tidak dapat diakses pada hari Sabtu pukul 22.00 - 06.00 WIB.",
      "time": "3 Hari yang lalu",
      "type": "Info",
      "isRead": true,
    },
    {
      "id": 5,
      "title": "Nilai Mata Kuliah Keluar",
      "body": "Nilai mata kuliah Pemrograman Mobile telah divalidasi dosen.",
      "time": "4 Hari yang lalu",
      "type": "Akademik",
      "isRead": true,
    },
  ];

  // Fungsi Hapus Notifikasi
  void _deleteNotification(int id) {
    setState(() {
      _allNotifications.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Notifikasi dihapus"), duration: Duration(seconds: 1)),
    );
  }

  // Fungsi Tandai Semua Dibaca
  void _markAllAsRead() {
    setState(() {
      for (var n in _allNotifications) {
        n['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Semua notifikasi ditandai sudah dibaca")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      // --- APP BAR DENGAN WARNA BIRU ---
      appBar: AppBar(
        title: const Text(
          "Notifikasi", 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
        ),
        centerTitle: true,
        backgroundColor: primaryColor, // KEMBALI KE WARNA BIRU
        foregroundColor: Colors.white, // Teks & Icon Putih
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _markAllAsRead,
            icon: const Icon(Icons.playlist_add_check_rounded),
            tooltip: "Tandai semua dibaca",
          )
        ],
      ),
      body: Column(
        children: [
          // Dekorasi lengkung kecil di bawah AppBar agar terlihat menyatu
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
          
          const SizedBox(height: 10), 
          
          Expanded(
            child: _allNotifications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: _allNotifications.length,
                    itemBuilder: (context, index) {
                      final item = _allNotifications[index];
                      return _buildNotificationCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET ITEM NOTIFIKASI (Swipeable) ---
  Widget _buildNotificationCard(Map<String, dynamic> item) {
    IconData icon;
    Color iconColor;
    Color iconBg;

    // Menentukan Style berdasarkan Tipe
    switch (item['type']) {
      case 'Akademik':
        icon = Icons.school_rounded;
        iconColor = Colors.blue;
        iconBg = Colors.blue.shade50;
        break;
      case 'Keuangan':
        icon = Icons.account_balance_wallet_rounded;
        iconColor = Colors.orange;
        iconBg = Colors.orange.shade50;
        break;
      case 'Agenda':
        icon = Icons.event_note_rounded;
        iconColor = Colors.purple;
        iconBg = Colors.purple.shade50;
        break;
      default: // Info
        icon = Icons.notifications_rounded;
        iconColor = const Color(0xFF050542);
        iconBg = const Color(0xFFE8EAF6);
    }

    return Dismissible(
      key: Key(item['id'].toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => _deleteNotification(item['id']),
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 28),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
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
          // Border kiri untuk indikator tipe
          border: Border(
            left: BorderSide(color: iconColor, width: 4),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Bubble
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tipe Notifikasi (Kecil)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item['type'].toUpperCase(),
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                        ),
                      ),
                      // Time
                      Text(
                        item['time'],
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Title
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: item['isRead'] ? FontWeight.w600 : FontWeight.bold,
                      color: const Color(0xFF050542),
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // Body
                  Text(
                    item['body'],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.4),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Indikator Belum Dibaca
            if (!item['isRead'])
              Container(
                margin: const EdgeInsets.only(left: 10, top: 15),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.redAccent, blurRadius: 4, spreadRadius: 1)
                  ]
                ),
              ),
          ],
        ),
      ),
    );
  }

  // --- EMPTY STATE ---
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))
              ]
            ),
            child: Icon(Icons.notifications_off_outlined, size: 50, color: Colors.grey.shade300),
          ),
          const SizedBox(height: 20),
          Text(
            "Tidak ada notifikasi",
            style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}