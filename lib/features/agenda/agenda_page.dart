import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'agenda_tambah.dart';
import '/data/models/agenda_model.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  // Warna Tema
  final Color primaryColor = const Color(0xFF050542);
  final Color accentColor = const Color(0xFFFFA726);

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<AgendaEvent> _myEvents = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    // --- DUMMY DATA ---
    _myEvents.add(AgendaEvent(
      title: "Rapat Prodi",
      description: "Membahas kurikulum baru",
      isMultiDay: false,
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      timeStart: const TimeOfDay(hour: 9, minute: 0),
      timeEnd: const TimeOfDay(hour: 11, minute: 0),
      color: Colors.red,
    ));

    _myEvents.add(AgendaEvent(
      title: "Workshop Flutter",
      description: "Pelatihan Mobile Apps Intensif",
      isMultiDay: true,
      startTime: DateTime.now().add(const Duration(days: 2)),
      endTime: DateTime.now().add(const Duration(days: 5)),
      timeStart: const TimeOfDay(hour: 8, minute: 0),
      timeEnd: const TimeOfDay(hour: 16, minute: 0),
      color: Colors.blue,
    ));
    
    _myEvents.add(AgendaEvent(
      title: "Olahraga Bersama",
      description: "Senam pagi di lapangan rektorat",
      isMultiDay: false,
      startTime: DateTime.now().add(const Duration(days: 2)),
      endTime: DateTime.now().add(const Duration(days: 2)),
      timeStart: const TimeOfDay(hour: 7, minute: 0),
      timeEnd: const TimeOfDay(hour: 8, minute: 0),
      color: Colors.green,
    ));
  }

  List<AgendaEvent> _getEventsForDay(DateTime day) {
    return _myEvents.where((event) {
      if (event.isMultiDay) {
        final date = DateTime(day.year, day.month, day.day);
        final start = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);
        final end = DateTime(event.endTime.year, event.endTime.month, event.endTime.day);
        return (date.isAtSameMomentAs(start) || date.isAfter(start)) &&
               (date.isAtSameMomentAs(end) || date.isBefore(end));
      } else {
        return isSameDay(event.startTime, day);
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Agenda Akademik", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      
      // --- UPDATE: Ganti FAB Extended menjadi FAB Biasa (Icon Only) ---
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AgendaTambahPage())
          );
          if (result != null && result is AgendaEvent) {
            setState(() {
              _myEvents.add(result);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Agenda berhasil ditambahkan"), backgroundColor: Colors.green),
            );
          }
        },
        backgroundColor: accentColor,
        elevation: 4,
        shape: const CircleBorder(), // Memastikan bentuk bulat sempurna
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
      // -------------------------------------------------------------

      body: Stack(
        children: [
          // --- 1. HEADER GRADIENT ---
          Container(
            height: 280, 
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, const Color(0xFF0A0F6C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          
          // Dekorasi Lingkaran
          Positioned(
            top: -60, right: -40,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
            ),
          ),

          // --- 2. KONTEN UTAMA ---
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10), // Spacer dari AppBar
                
                // --- KARTU KALENDER (WHITE CARD) ---
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    
                    // --- STYLE HEADER KALENDER ---
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: Color(0xFF050542), 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold
                      ),
                      leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF050542)),
                      rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF050542)),
                    ),

                    // --- STYLE HARI ---
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                      weekendStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500),
                    ),

                    calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.black87),
                      weekendTextStyle: TextStyle(color: Colors.redAccent),
                      selectedDecoration: BoxDecoration(color: Colors.transparent), 
                      todayDecoration: BoxDecoration(color: Colors.transparent),
                    ),

                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    eventLoader: _getEventsForDay,

                    // --- CUSTOM BUILDERS ---
                    calendarBuilders: CalendarBuilders(
                      
                      // 1. MARKER BUILDER (Hanya untuk Single Day)
                      markerBuilder: (context, day, events) {
                        if (events.isEmpty) return null;
                        
                        final singleDayEvents = events
                            .where((e) => e is AgendaEvent && !e.isMultiDay)
                            .map((e) => e as AgendaEvent)
                            .toList();

                        if (singleDayEvents.isEmpty) return null;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: singleDayEvents.map((event) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1.5),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: event.color,
                              ),
                            );
                          }).toList(),
                        );
                      },

                      // 2. BACKGROUND BUILDER
                      defaultBuilder: (context, day, focusedDay) => _buildCell(day, false, false),
                      todayBuilder: (context, day, focusedDay) => _buildCell(day, true, false),
                      selectedBuilder: (context, day, focusedDay) => _buildCell(day, false, true),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // --- LIST AGENDA ---
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Agenda: ${DateFormat('dd MMMM yyyy', 'id_ID').format(_selectedDay!)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        Expanded(
                          child: selectedEvents.isEmpty
                              ? _buildEmptyState()
                              : ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 80),
                                  itemCount: selectedEvents.length,
                                  itemBuilder: (context, index) {
                                    return _buildEventCard(selectedEvents[index]);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER UNTUK MEMBANGUN KOTAK TANGGAL ---
  Widget _buildCell(DateTime day, bool isToday, bool isSelected) {
    final events = _getEventsForDay(day);
    final multiDayEvent = events.isEmpty 
        ? null 
        : events.firstWhere((e) => e.isMultiDay, orElse: () => events.first); 
        
    final bool isMultiDay = events.any((e) => e.isMultiDay);
    Color? bgColor;
    Color textColor = Colors.black87;

    if (isSelected) {
      bgColor = primaryColor;
      textColor = Colors.white;
    } else if (isToday) {
      bgColor = accentColor.withOpacity(0.3);
      textColor = primaryColor;
    } else if (isMultiDay && multiDayEvent != null) {
      bgColor = multiDayEvent.color.withOpacity(0.2); 
    }

    return Container(
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: (isToday && !isSelected) 
            ? Border.all(color: accentColor, width: 2) 
            : null,
      ),
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: textColor,
          fontWeight: (isSelected || isToday) ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // --- HELPER EMPTY STATE ---
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_note_rounded, size: 60, color: Colors.grey[300]),
          const SizedBox(height: 10),
          Text(
            "Tidak ada kegiatan",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }

  // --- HELPER KARTU EVENT ---
  Widget _buildEventCard(AgendaEvent event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: event.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            event.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (event.isMultiDay)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: event.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "Multi-day",
                              style: TextStyle(fontSize: 10, color: event.color, fontWeight: FontWeight.bold),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 6),
                        Text(
                          "${event.timeStart.format(context)} - ${event.timeEnd.format(context)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    if (event.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}