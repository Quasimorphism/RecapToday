import 'package:flutter/material.dart';
import 'package:test6/utils/app_theme.dart';

class SettingsModal extends StatefulWidget {
  const SettingsModal({super.key});

  @override
  State<SettingsModal> createState() => _SettingsModalState();
}

class _SettingsModalState extends State<SettingsModal> {
  // Mock user data (replace with actual data later)
  final Map<String, dynamic> _userData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'profileImage': null, // Add profile image URL later
  };

  bool _notificationsEnabled = true;
  bool _darkMode = false;
  final String _selectedTheme = 'Blue';
  bool _syncCalendar = true;
  bool _locationTracking = true;
  bool _appUsageTracking = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppTheme.darkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // User Profile Section
            Container(
              decoration: BoxDecoration(
                color: AppTheme.lightBlue.withValues(alpha: 0.3 * 255),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppTheme.primaryColor,
                    child:
                        _userData['profileImage'] != null
                            ? null
                            : Text(
                              _userData['name'].substring(0, 1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userData['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _userData['email'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Edit profile functionality
                    },
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // General Settings
            Text(
              'General',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Notifications
            SwitchListTile(
              title: const Text('Notifications'),
              subtitle: const Text('Enable push notifications'),
              value: _notificationsEnabled,
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),

            // Dark Mode
            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Switch to dark theme'),
              value: _darkMode,
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),

            // Theme Selection
            ListTile(
              title: const Text('Theme'),
              subtitle: Text(_selectedTheme),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Show theme selection dialog
              },
            ),

            const Divider(),

            // Data Settings
            Text(
              'Data & Privacy',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Calendar Sync
            SwitchListTile(
              title: const Text('Sync Calendar'),
              subtitle: const Text('Sync with device calendar'),
              value: _syncCalendar,
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  _syncCalendar = value;
                });
              },
            ),

            // Location Tracking
            SwitchListTile(
              title: const Text('Location Tracking'),
              subtitle: const Text('Allow location tracking for daily recap'),
              value: _locationTracking,
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  _locationTracking = value;
                });
              },
            ),

            // App Usage Tracking
            SwitchListTile(
              title: const Text('App Usage Tracking'),
              subtitle: const Text('Track app usage for daily recap'),
              value: _appUsageTracking,
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  _appUsageTracking = value;
                });
              },
            ),

            const Divider(),

            // API Settings
            Text(
              'API Settings',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Weather API
            ListTile(
              title: const Text('Weather API Key'),
              subtitle: const Text('Set your weather API key'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Show API key setting dialog
              },
            ),

            // Map API
            ListTile(
              title: const Text('Map API Key'),
              subtitle: const Text('Set your map API key'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Show API key setting dialog
              },
            ),

            // AI API
            ListTile(
              title: const Text('AI API Key'),
              subtitle: const Text('Set your AI API key for daily feedback'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Show API key setting dialog
              },
            ),

            const SizedBox(height: 24),

            // Logout & Account Actions
            Center(
              child: OutlinedButton(
                onPressed: () {
                  // Logout functionality
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text('Log Out'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
