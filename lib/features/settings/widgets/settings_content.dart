import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';

/// Settings page content with app configuration options
class SettingsContent extends StatefulWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  // Treatment Settings
  int _guaShaDefaultMinutes = 20;
  int _electricStimDefaultMinutes = 45;
  bool _autoStartCamera = true;
  bool _requireNotes = false;

  // Notification Settings
  bool _notificationsEnabled = true;
  bool _treatmentReminders = true;
  bool _achievementNotifications = true;
  bool _dailyTips = true;
  bool _notificationSound = true;
  bool _vibration = true;

  // Display Settings
  String _theme = 'Auto';
  String _language = 'English';
  String _dateFormat = 'DD/MM/YYYY';
  String _timeFormat = '12h';

  // Calendar Settings
  bool _calendarIntegration = false;
  bool _syncToDeviceCalendar = false;

  // Data Settings
  String _photoStorage = 'App Storage';
  bool _autoBackup = true;

  // Expanded sections state
  bool _treatmentExpanded = true;
  bool _notificationsExpanded = true;
  bool _displayExpanded = true;
  bool _calendarExpanded = true;
  bool _dataExpanded = true;
  bool _aboutExpanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Customize your app experience',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          // Treatment Settings
          _buildSection(
            theme: theme,
            title: 'Treatment Settings',
            icon: Icons.spa,
            color: kSNDPigmentGreen,
            isExpanded: _treatmentExpanded,
            onToggle: () => setState(() => _treatmentExpanded = !_treatmentExpanded),
            children: [
              _buildSliderSetting(
                theme,
                'Gua Sha Default Time',
                _guaShaDefaultMinutes,
                10,
                60,
                'minutes',
                (value) => setState(() => _guaShaDefaultMinutes = value.round()),
              ),
              _buildDivider(),
              _buildSliderSetting(
                theme,
                'Electric Stimulator Default Time',
                _electricStimDefaultMinutes,
                20,
                90,
                'minutes',
                (value) => setState(() => _electricStimDefaultMinutes = value.round()),
              ),
              _buildDivider(),
              _buildSwitchSetting(
                theme,
                'Auto-start Camera',
                'Automatically open camera after treatment',
                _autoStartCamera,
                (value) => setState(() => _autoStartCamera = value),
              ),
              _buildDivider(),
              _buildSwitchSetting(
                theme,
                'Require Notes',
                'Prompt to add notes after each treatment',
                _requireNotes,
                (value) => setState(() => _requireNotes = value),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Notification Settings
          _buildSection(
            theme: theme,
            title: 'Notifications',
            icon: Icons.notifications_outlined,
            color: kSNDYellowGreen,
            isExpanded: _notificationsExpanded,
            onToggle: () => setState(() => _notificationsExpanded = !_notificationsExpanded),
            children: [
              _buildSwitchSetting(
                theme,
                'Enable Notifications',
                'Master switch for all notifications',
                _notificationsEnabled,
                (value) => setState(() => _notificationsEnabled = value),
              ),
              _buildDivider(),
              _buildSwitchSetting(
                theme,
                'Treatment Reminders',
                'Get reminded about scheduled treatments',
                _treatmentReminders,
                (value) => setState(() => _treatmentReminders = value),
                enabled: _notificationsEnabled,
              ),
              _buildDivider(),
              _buildSwitchSetting(
                theme,
                'Achievement Notifications',
                'Celebrate your milestones',
                _achievementNotifications,
                (value) => setState(() => _achievementNotifications = value),
                enabled: _notificationsEnabled,
              ),
              _buildDivider(),
              _buildSwitchSetting(
                theme,
                'Daily Tips',
                'Receive helpful treatment tips',
                _dailyTips,
                (value) => setState(() => _dailyTips = value),
                enabled: _notificationsEnabled,
              ),
              _buildDivider(),
              _buildSwitchSetting(
                theme,
                'Notification Sound',
                'Play sound for notifications',
                _notificationSound,
                (value) => setState(() => _notificationSound = value),
                enabled: _notificationsEnabled,
              ),
              _buildDivider(),
              _buildSwitchSetting(
                theme,
                'Vibration',
                'Vibrate for notifications',
                _vibration,
                (value) => setState(() => _vibration = value),
                enabled: _notificationsEnabled,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Display & Appearance
          _buildSection(
            theme: theme,
            title: 'Display & Appearance',
            icon: Icons.palette_outlined,
            color: kSNDJade,
            isExpanded: _displayExpanded,
            onToggle: () => setState(() => _displayExpanded = !_displayExpanded),
            children: [
              _buildChoiceSetting(
                theme,
                'Theme',
                _theme,
                ['Light', 'Dark', 'Auto'],
                (value) => setState(() => _theme = value),
              ),
              _buildDivider(),
              _buildChoiceSetting(
                theme,
                'Language',
                _language,
                ['English', 'Spanish', 'French', 'German'],
                (value) => setState(() => _language = value),
              ),
              _buildDivider(),
              _buildChoiceSetting(
                theme,
                'Date Format',
                _dateFormat,
                ['DD/MM/YYYY', 'MM/DD/YYYY', 'YYYY-MM-DD'],
                (value) => setState(() => _dateFormat = value),
              ),
              _buildDivider(),
              _buildChoiceSetting(
                theme,
                'Time Format',
                _timeFormat,
                ['12h', '24h'],
                (value) => setState(() => _timeFormat = value),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Calendar & Sync
          _buildSection(
            theme: theme,
            title: 'Calendar & Sync',
            icon: Icons.calendar_today_outlined,
            color: kSNDCeladon,
            isExpanded: _calendarExpanded,
            onToggle: () => setState(() => _calendarExpanded = !_calendarExpanded),
            children: [
              _buildSwitchSetting(
                theme,
                'Calendar Integration',
                'Show treatments in calendar app',
                _calendarIntegration,
                (value) => setState(() => _calendarIntegration = value),
              ),
              _buildDivider(),
              _buildSwitchSetting(
                theme,
                'Sync to Device Calendar',
                'Automatically add sessions to calendar',
                _syncToDeviceCalendar,
                (value) => setState(() => _syncToDeviceCalendar = value),
                enabled: _calendarIntegration,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Data & Privacy
          _buildSection(
            theme: theme,
            title: 'Data & Privacy',
            icon: Icons.storage_outlined,
            color: Colors.deepPurple,
            isExpanded: _dataExpanded,
            onToggle: () => setState(() => _dataExpanded = !_dataExpanded),
            children: [
              _buildChoiceSetting(
                theme,
                'Photo Storage',
                _photoStorage,
                ['App Storage', 'Device Gallery', 'Cloud'],
                (value) => setState(() => _photoStorage = value),
              ),
              _buildDivider(),
              _buildSwitchSetting(
                theme,
                'Auto-backup Photos',
                'Backup photos to cloud storage',
                _autoBackup,
                (value) => setState(() => _autoBackup = value),
              ),
              _buildDivider(),
              _buildActionRow(
                theme,
                'Clear Cache',
                Icons.cleaning_services,
                'Free up storage space',
                () => _showClearCacheDialog(context),
              ),
              _buildDivider(),
              _buildInfoRow(
                theme,
                'Data Usage',
                '125 MB',
                Icons.data_usage,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // About & Support
          _buildSection(
            theme: theme,
            title: 'About & Support',
            icon: Icons.info_outline,
            color: Colors.blueGrey,
            isExpanded: _aboutExpanded,
            onToggle: () => setState(() => _aboutExpanded = !_aboutExpanded),
            children: [
              _buildInfoRow(
                theme,
                'App Version',
                '1.0.0',
                Icons.app_settings_alt,
              ),
              _buildDivider(),
              _buildActionRow(
                theme,
                'Terms of Service',
                Icons.description_outlined,
                '',
                () => _showInfoDialog(context, 'Terms of Service'),
              ),
              _buildDivider(),
              _buildActionRow(
                theme,
                'Privacy Policy',
                Icons.privacy_tip_outlined,
                '',
                () => _showInfoDialog(context, 'Privacy Policy'),
              ),
              _buildDivider(),
              _buildActionRow(
                theme,
                'Contact Support',
                Icons.support_agent,
                '',
                () => _showSupportDialog(context),
              ),
              _buildDivider(),
              _buildActionRow(
                theme,
                'Rate the App',
                Icons.star_outline,
                '',
                () => _showRateDialog(context),
              ),
              _buildDivider(),
              _buildActionRow(
                theme,
                'Help Center',
                Icons.help_outline,
                '',
                () => _showInfoDialog(context, 'Help Center'),
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSection({
    required ThemeData theme,
    required String title,
    IconData? icon,
    String? imagePath,
    required Color color,
    required bool isExpanded,
    required VoidCallback onToggle,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  imagePath != null
                      ? Image.asset(
                          imagePath,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        )
                      : Icon(icon, color: color, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: color,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSwitchSetting(
    ThemeData theme,
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged, {
    bool enabled = true,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: kSNDPigmentGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting(
    ThemeData theme,
    String title,
    int value,
    double min,
    double max,
    String unit,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kSNDPigmentGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '$value $unit',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kSNDPigmentGreen,
                ),
              ),
            ),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: min,
          max: max,
          divisions: ((max - min) / 5).round(),
          onChanged: onChanged,
          activeColor: kSNDPigmentGreen,
        ),
      ],
    );
  }

  Widget _buildChoiceSetting(
    ThemeData theme,
    String title,
    String value,
    List<String> options,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = option == value;
            return GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? kSNDPigmentGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? kSNDPigmentGreen
                        : theme.colorScheme.outline.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Text(
                  option,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionRow(
    ThemeData theme,
    String title,
    IconData icon,
    String? subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 24, color: kSNDJade),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null && subtitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurface.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    ThemeData theme,
    String title,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 24, color: kSNDJade),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.2),
      height: 1,
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will free up storage space. Your photos and data will not be affected.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('$title content will be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Get help with:'),
            const SizedBox(height: 12),
            Text('Email: support@snd-aas.com'),
            const SizedBox(height: 8),
            Text('Phone: 1-800-SND-HELP'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate the App'),
        content: const Text('Thank you for using our app! Would you like to rate us on the app store?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening app store...')),
              );
            },
            child: const Text('Rate Now'),
          ),
        ],
      ),
    );
  }
}
