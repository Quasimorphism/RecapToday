import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:test6/utils/app_theme.dart';
import 'package:test6/widgets/settings_modal.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  // Mock data (replace with SQLite queries later)
  final Map<DateTime, bool> _journalEntries = {
    DateTime.now(): true,
    DateTime.now().subtract(const Duration(days: 1)): true,
    DateTime.now().subtract(const Duration(days: 3)): true,
  };

  final Map<DateTime, bool> _recapEntries = {
    DateTime.now(): true,
    DateTime.now().subtract(const Duration(days: 1)): true,
    DateTime.now().subtract(const Duration(days: 2)): true,
  };

  // Mock journal for selected day (replace with SQLite data)
  final Map<String, dynamic> _selectedJournal = {
    'title': 'A Productive Day',
    'content':
        'Today was very productive. I completed my project ahead of schedule and had time to go for a run in the evening.',
    'images': [
      'https://picsum.photos/200/300',
      'https://picsum.photos/200/300',
    ],
  };

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsModal(),
    );
  }

  bool _hasJournalForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _journalEntries[normalizedDay] ?? false;
  }

  bool _hasRecapForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _recapEntries[normalizedDay] ?? false;
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    final events = [];
    if (_hasJournalForDay(day)) events.add('journal');
    if (_hasRecapForDay(day)) events.add('recap');
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Calendar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: _showSettingsModal,
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar section
          Card(
            margin: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.5 * 255),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: AppTheme.accentColor,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: true,
                formatButtonDecoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: const TextStyle(color: Colors.white),
                titleTextStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Date header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              DateFormat('EEEE, MMMM d, yyyy').format(_selectedDay),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          // Daily Recap section if available
          if (_hasRecapForDay(_selectedDay))
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  // Daily recap widget
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Daily Recap',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: AppTheme.primaryColor,
                                ),
                                onPressed: () {
                                  // Navigate to full recap screen for this day
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 120,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(
                                  Icons.map,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text('Your movement map for the day'),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.phone_android,
                                      color: AppTheme.primaryColor,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('3h 45m'),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Screen time',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.directions_walk,
                                      color: AppTheme.primaryColor,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('7,245'),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Steps',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.task_alt,
                                      color: AppTheme.primaryColor,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('4/6'),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Tasks completed',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
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

                  const SizedBox(height: 16),

                  // Journal card if available
                  if (_hasJournalForDay(_selectedDay))
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Journal',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: AppTheme.primaryColor,
                                  ),
                                  onPressed: () {
                                    // Navigate to full journal screen for this day
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _selectedJournal['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Image preview if available
                            if (_selectedJournal['images'] != null &&
                                _selectedJournal['images'].isNotEmpty)
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _selectedJournal['images'].length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          width: 100,
                                          color: Colors.grey[300],
                                          child: const Center(
                                            child: Icon(
                                              Icons.image,
                                              size: 32,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 8),

                            Text(
                              _selectedJournal['content'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No data for selected day',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
