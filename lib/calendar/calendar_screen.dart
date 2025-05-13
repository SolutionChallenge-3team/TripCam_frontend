import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '/common/navbar.dart';

class AppColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF000000);
  static const Color subText = Color(0xFFD9D9D9);
  static const Color main = Color(0xFF0000EF);
  static const Color sub = Color(0xFF2449FF);
}

const _labelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  fontFamily: 'Pretendard',
);

const _hintStyle = TextStyle(fontFamily: 'Pretendard', color: Colors.grey);

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedIndex = 2;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<Map<String, dynamic>>> _events = {};

  String _newEventTitle = '';
  String _newEventLocation = '';
  DateTime _newEventTime = DateTime.now();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
    });
  }

  void _jumpToDate() {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => Container(
            height: 300,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      '완료',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.sub,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _focusedDay,
                    minimumDate: DateTime(2020),
                    maximumDate: DateTime(2030),
                    onDateTimeChanged: (picked) {
                      setState(() {
                        _focusedDay = picked;
                        _selectedDay = picked;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _showEventModal(DateTime date) {
    final events = _getEventsForDay(date);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('yyyy년 M월 d일', 'ko_KR').format(date),
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (events.isEmpty)
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '등록된 일정이 없습니다.',
                      style: TextStyle(fontFamily: 'Pretendard'),
                    ),
                  ),
                )
              else
                ...events.map(
                  (event) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 10,
                          color: AppColors.sub,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${event['time']} - ${event['title']} (${event['location']})',
                            style: const TextStyle(fontFamily: 'Pretendard'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showAddEventSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFDFCF9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            top: 24,
            left: 24,
            right: 24,
          ),
          child: StatefulBuilder(
            builder: (context, modalSetState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "일정 추가",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text("제목", style: _labelStyle),
                  TextField(
                    onChanged: (val) => _newEventTitle = val,
                    decoration: const InputDecoration(
                      hintStyle: _hintStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.subText),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.sub),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text("시간", style: _labelStyle),
                  const SizedBox(height: 8),
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.subText),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: _newEventTime,
                      use24hFormat: false,
                      onDateTimeChanged: (newTime) {
                        setState(() {
                          _newEventTime = newTime;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text("위치", style: _labelStyle),
                  TextField(
                    onChanged: (val) => _newEventLocation = val,
                    decoration: const InputDecoration(
                      hintStyle: _hintStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.subText),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.sub),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sub,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        if (_newEventTitle.isNotEmpty) {
                          final formatted = DateFormat(
                            'h:mm a',
                          ).format(_newEventTime);
                          _addEvent(
                            _newEventTitle,
                            formatted,
                            _newEventLocation,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "추가하기",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _addEvent(String title, String time, String location) {
    final day = DateTime.utc(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );

    setState(() {
      final currentEvents = _events[day] ?? [];

      currentEvents.add({'title': title, 'time': time, 'location': location});

      currentEvents.sort((a, b) {
        final timeA = DateFormat('h:mm a').parse(a['time']);
        final timeB = DateFormat('h:mm a').parse(b['time']);
        return timeA.compareTo(timeB);
      });

      _events[day] = currentEvents;
    });
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _goToPreviousMonth,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: _jumpToDate,
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: _goToNextMonth,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    DateFormat('yyyy. M', 'ko_KR').format(_focusedDay),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TableCalendar(
                locale: 'ko_KR',
                firstDay: DateTime(2020),
                lastDay: DateTime(2030),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                  });
                  _showEventModal(selected);
                },
                eventLoader:
                    (day) => _getEventsForDay(day).isNotEmpty ? ['event'] : [],
                headerVisible: false,
                calendarStyle: const CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: AppColors.sub,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: AppColors.sub,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  weekendStyle: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.add, color: AppColors.sub),
          onPressed: _showAddEventSheet,
        ),
      ),
    );
  }
}
