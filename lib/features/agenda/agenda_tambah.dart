import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/data/models/agenda_model.dart';

class AgendaTambahPage extends StatefulWidget {
  const AgendaTambahPage({super.key});

  @override
  State<AgendaTambahPage> createState() => _AgendaTambahPageState();
}

class _AgendaTambahPageState extends State<AgendaTambahPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  
  bool _isMultiDay = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  
  Color _selectedColor = Colors.blue;
  final List<Color> _colors = [
    Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple, Colors.teal
  ];

  final Color primaryColor = const Color(0xFF050542);
  final Color accentColor = const Color(0xFFFFA726);

  // --- LOGIC HELPER ---
  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: primaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: primaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) _startTime = picked;
        else _endTime = picked;
      });
    }
  }

  void _saveAgenda() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Judul agenda harus diisi"), behavior: SnackBarBehavior.floating),
      );
      return;
    }

    final newEvent = AgendaEvent(
      title: _titleController.text,
      description: _descController.text,
      isMultiDay: _isMultiDay,
      startTime: _startDate,
      endTime: _isMultiDay ? _endDate : _startDate,
      timeStart: _startTime,
      timeEnd: _endTime,
      color: _selectedColor,
    );

    Navigator.pop(context, newEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Tambah Agenda", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: Stack(
        children: [
          // 1. BACKGROUND GRADIENT
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, const Color(0xFF0A0F6C)],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          
          // 2. ORNAMEN
          Positioned(
            top: -50, right: -50,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
            ),
          ),

          // 3. FORM CARD
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10), // Jarak dari AppBar
                  
                  Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- INPUT JUDUL ---
                        _buildSectionLabel("Judul Agenda"),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _titleController,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          decoration: _buildInputDecoration("Contoh: Rapat Dosen", Icons.title),
                        ),
                        
                        const SizedBox(height: 24),

                        // --- JENIS AGENDA (TOGGLE) ---
                        _buildSectionLabel("Jenis Agenda"),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(child: _buildToggleBtn("Satu Hari", !_isMultiDay)),
                              Expanded(child: _buildToggleBtn("Banyak Hari", _isMultiDay)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),
                        
                        // --- TANGGAL ---
                        _buildSectionLabel("Tanggal"),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateTimeBox(
                                label: _isMultiDay ? "Mulai" : "Tanggal",
                                value: DateFormat('dd MMM yyyy').format(_startDate),
                                icon: Icons.calendar_today_rounded,
                                onTap: () => _pickDate(true),
                              ),
                            ),
                            if (_isMultiDay) ...[
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildDateTimeBox(
                                  label: "Selesai",
                                  value: DateFormat('dd MMM yyyy').format(_endDate),
                                  icon: Icons.event_available_rounded,
                                  onTap: () => _pickDate(false),
                                ),
                              ),
                            ]
                          ],
                        ),

                        const SizedBox(height: 16),

                        // --- WAKTU ---
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateTimeBox(
                                label: "Jam Mulai",
                                value: _startTime.format(context),
                                icon: Icons.access_time_rounded,
                                onTap: () => _pickTime(true),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDateTimeBox(
                                label: "Jam Selesai",
                                value: _endTime.format(context),
                                icon: Icons.timer_off_outlined,
                                onTap: () => _pickTime(false),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // --- KETERANGAN ---
                        _buildSectionLabel("Keterangan"),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _descController,
                          maxLines: 3,
                          decoration: _buildInputDecoration("Tambahkan catatan...", Icons.notes),
                        ),

                        const SizedBox(height: 24),

                        // --- WARNA ---
                        _buildSectionLabel("Warna Label"),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _colors.map((color) => GestureDetector(
                            onTap: () => setState(() => _selectedColor = color),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  if(_selectedColor == color)
                                    BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))
                                ],
                                border: Border.all(
                                  color: _selectedColor == color ? Colors.white : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: _selectedColor == color 
                                ? const Icon(Icons.check, color: Colors.white, size: 20) 
                                : null,
                            ),
                          )).toList(),
                        ),

                        const SizedBox(height: 32),

                        // --- TOMBOL SIMPAN ---
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _saveAgenda,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 5,
                              shadowColor: primaryColor.withOpacity(0.3),
                            ),
                            child: const Text(
                              "Simpan Agenda",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    );
  }

  // Toggle Button (Custom Radio)
  Widget _buildToggleBtn(String text, bool isActive) {
    return GestureDetector(
      onTap: () => setState(() => _isMultiDay = text == "Banyak Hari"),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive ? [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
          ] : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFF050542) : Colors.grey[500],
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Kotak Input Tanggal/Waktu
  Widget _buildDateTimeBox({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(icon, size: 18, color: const Color(0xFF050542)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
      filled: true,
      fillColor: Colors.grey[50],
      prefixIcon: Icon(icon, color: Colors.grey[400], size: 22),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }
}