import 'package:flutter/material.dart';

// --- MODEL DATA ---
class CourseGrade {
  final String code;
  final String section;
  final String name;
  final int sKs;
  final String grade; // A, B, C...
  final double weight; // 4.0, 3.0...

  CourseGrade({
    required this.code,
    required this.section,
    required this.name,
    required this.sKs,
    required this.grade,
    required this.weight,
  });
}

class SemesterResult {
  final String periodName; // e.g., "Januari - Juni 2024"
  final int totalSks;
  final double totalMutu;
  final double ips; // Indeks Prestasi Semester
  final List<CourseGrade> courses;

  SemesterResult({
    required this.periodName,
    required this.totalSks,
    required this.totalMutu,
    required this.ips,
    required this.courses,
  });
}

class TranskripPage extends StatefulWidget {
  const TranskripPage({super.key});

  @override
  State<TranskripPage> createState() => _TranskripPageState();
}

class _TranskripPageState extends State<TranskripPage> {
  // Warna Tema
  final Color primaryColor = const Color(0xFF050542);
  final Color accentColor = const Color(0xFFFFA726);

  // --- DUMMY DATA ---
  // Data Keseluruhan (Kumulatif)
  final double _ipk = 3.85;
  final int _totalSksTaken = 110;
  final double _totalMutuTaken = 423.5;
  final int _totalSemester = 6;

  // Data Per Semester
  final List<SemesterResult> _semesterHistory = [
    SemesterResult(
      periodName: "Juli - Desember 2025",
      totalSks: 22,
      totalMutu: 88.0,
      ips: 4.00,
      courses: [
        CourseGrade(code: "TIF3301", section: "20241123", name: "Kecerdasan Buatan", sKs: 3, grade: "A", weight: 4.0),
        CourseGrade(code: "TIF3302", section: "20241124", name: "Pengolahan Citra", sKs: 3, grade: "A", weight: 4.0),
        CourseGrade(code: "UNP001", section: "20241125", name: "KKN", sKs: 4, grade: "A", weight: 4.0),
        CourseGrade(code: "TIF3305", section: "20241126", name: "Sistem Terdistribusi", sKs: 3, grade: "A", weight: 4.0),
        CourseGrade(code: "TIF3309", section: "20241127", name: "Proyek Perangkat Lunak", sKs: 3, grade: "A", weight: 4.0),
      ],
    ),
    SemesterResult(
      periodName: "Januari - Juni 2025",
      totalSks: 21,
      totalMutu: 78.75,
      ips: 3.75,
      courses: [
        CourseGrade(code: "TIF2201", section: "20232201", name: "Pemrograman Mobile", sKs: 3, grade: "A", weight: 4.0),
        CourseGrade(code: "TIF2202", section: "20232202", name: "Basis Data Lanjut", sKs: 3, grade: "B+", weight: 3.5),
        CourseGrade(code: "TIF2203", section: "20232203", name: "Statistika", sKs: 2, grade: "A-", weight: 3.75),
        CourseGrade(code: "TIF2204", section: "20232204", name: "Jaringan Komputer", sKs: 3, grade: "A", weight: 4.0),
      ],
    ),
    SemesterResult(
      periodName: "Juli - Desember 2024",
      totalSks: 20,
      totalMutu: 70.0,
      ips: 3.50,
      courses: [
        CourseGrade(code: "TIF1101", section: "20231101", name: "Algoritma & Pemrograman", sKs: 4, grade: "B", weight: 3.0),
        CourseGrade(code: "TIF1102", section: "20231102", name: "Matematika Diskrit", sKs: 3, grade: "A", weight: 4.0),
        CourseGrade(code: "TIF1103", section: "20231103", name: "Sistem Operasi", sKs: 3, grade: "B+", weight: 3.5),
      ],
    ),
  ];

  // State Pilihan Semester
  late SemesterResult _selectedSemester;

  @override
  void initState() {
    super.initState();
    // Default pilih semester paling atas (terbaru)
    _selectedSemester = _semesterHistory.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Transkrip Nilai", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. SECTION IPK KOMULATIF (HEADER) ---
            Container(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Text("Prestasi Akademik Kumulatif", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatBox("Semester", "$_totalSemester"),
                      _buildStatBox("Total SKS", "$_totalSksTaken"),
                      _buildStatBox("Total Mutu", "$_totalMutuTaken"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Indikator IPK Besar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: accentColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("IPK Saat Ini", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 15),
                        Text(
                          _ipk.toString(),
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- 2. DROPDOWN PILIH SEMESTER ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<SemesterResult>(
                    value: _selectedSemester,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14),
                    onChanged: (SemesterResult? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSemester = newValue;
                        });
                      }
                    },
                    items: _semesterHistory.map<DropdownMenuItem<SemesterResult>>((SemesterResult value) {
                      return DropdownMenuItem<SemesterResult>(
                        value: value,
                        child: Text(value.periodName),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- 3. SUMMARY SEMESTER TERPILIH ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(child: _buildSemesterInfoCard("SKS Diambil", "${_selectedSemester.totalSks}", Colors.blue[50]!, Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildSemesterInfoCard("Mutu Smt", "${_selectedSemester.totalMutu}", Colors.orange[50]!, Colors.orange)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildSemesterInfoCard("IPS", "${_selectedSemester.ips}", Colors.green[50]!, Colors.green)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- 4. TABEL MATA KULIAH ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Tabel
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Rincian Nilai",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ),
                  const Divider(height: 1),
                  
                  // Tabel Data
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.grey[200]),
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(primaryColor.withOpacity(0.05)),
                        columnSpacing: 20,
                        horizontalMargin: 20,
                        columns: const [
                          DataColumn(label: Text('No', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Seksi', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Mata Kuliah', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('SKS', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Nilai', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Bobot', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: List<DataRow>.generate(
                          _selectedSemester.courses.length,
                          (index) {
                            final course = _selectedSemester.courses[index];
                            return DataRow(
                              cells: [
                                DataCell(Text((index + 1).toString())),
                                DataCell(Text(course.section)),
                                DataCell(
                                  SizedBox(
                                    width: 150, // Batasi lebar nama matkul
                                    child: Text(
                                      course.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                DataCell(Center(child: Text('${course.sKs}'))),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _getGradeColor(course.grade).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      course.grade,
                                      style: TextStyle(
                                        color: _getGradeColor(course.grade),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(Center(child: Text('${course.weight}'))),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildStatBox(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildSemesterInfoCard(String label, String value, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12)),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) return Colors.green;
    if (grade.startsWith('B')) return Colors.blue;
    if (grade.startsWith('C')) return Colors.orange;
    return Colors.red;
  }
}