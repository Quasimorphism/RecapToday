import 'package:flutter/material.dart';
import 'package:test6/utils/app_theme.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock schedule data (replace with actual data from SQLite later)
    final schedules = [
      {
        'time': '09:00 - 10:30',
        'title': 'Team Meeting',
        'location': 'Conference Room',
      },
      {
        'time': '12:00 - 13:00',
        'title': 'Lunch Break',
        'location': 'Cafeteria',
      },
      {
        'time': '15:00 - 16:30',
        'title': 'Project Review',
        'location': 'Office',
      },
    ];

    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: 1, // Just showing today's schedule for now
        itemBuilder: (context, pageIndex) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time column
                    SizedBox(
                      width: 90,
                      child: Text(
                        schedule['time']!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    // Timeline column
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        if (index < schedules.length - 1)
                          Container(
                            width: 2,
                            height: 40,
                            color: Colors.grey[300],
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Event details column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schedule['title']!,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            schedule['location']!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
