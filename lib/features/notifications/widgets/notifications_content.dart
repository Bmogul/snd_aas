import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';
import 'package:snd_aas/features/notifications/models/app_notification.dart';
import 'package:snd_aas/features/notifications/models/weekly_routine.dart' as model;

/// Notifications page content with reminders and routine scheduling
class NotificationsContent extends StatefulWidget {
  const NotificationsContent({Key? key}) : super(key: key);

  @override
  State<NotificationsContent> createState() => _NotificationsContentState();
}

class _NotificationsContentState extends State<NotificationsContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<AppNotification> _notifications = [];
  late model.WeeklyRoutine _guaShaRoutine;
  late model.WeeklyRoutine _electricStimRoutine;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadMockData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadMockData() {
    final now = DateTime.now();

    // Mock notifications
    _notifications.addAll([
      AppNotification(
        id: '1',
        title: 'Time for Gua Sha!',
        message: 'Your scheduled Gua Sha treatment is coming up in 10 minutes.',
        timestamp: now.subtract(const Duration(minutes: 30)),
        type: NotificationType.reminder,
      ),
      AppNotification(
        id: '2',
        title: '3-Day Streak! 🎉',
        message: 'Great job! You\'ve completed treatments for 3 days in a row.',
        timestamp: now.subtract(const Duration(hours: 2)),
        type: NotificationType.achievement,
        isRead: true,
      ),
      AppNotification(
        id: '3',
        title: 'Treatment Tip',
        message: 'Remember to apply gentle pressure during Gua Sha for best results.',
        timestamp: now.subtract(const Duration(hours: 5)),
        type: NotificationType.tip,
        isRead: true,
      ),
      AppNotification(
        id: '4',
        title: 'Weekly Goal Achieved',
        message: 'You completed all your scheduled treatments this week!',
        timestamp: now.subtract(const Duration(days: 1)),
        type: NotificationType.achievement,
        isRead: true,
      ),
      AppNotification(
        id: '5',
        title: 'Missed Treatment',
        message: 'You missed your Electric Stimulator session yesterday.',
        timestamp: now.subtract(const Duration(days: 1, hours: 3)),
        type: NotificationType.system,
        isRead: true,
      ),
    ]);

    // Mock weekly routines
    _guaShaRoutine = model.WeeklyRoutine(
      treatmentType: 'Gua Sha',
      schedule: {
        1: const model.TimeOfDay(hour: 9, minute: 0), // Monday
        3: const model.TimeOfDay(hour: 9, minute: 0), // Wednesday
        5: const model.TimeOfDay(hour: 9, minute: 0), // Friday
        2: null,
        4: null,
        6: null,
        7: null,
      },
      isEnabled: true,
    );

    _electricStimRoutine = model.WeeklyRoutine(
      treatmentType: 'Electric Stimulator',
      schedule: {
        2: const model.TimeOfDay(hour: 18, minute: 30), // Tuesday
        4: const model.TimeOfDay(hour: 18, minute: 30), // Thursday
        1: null,
        3: null,
        5: null,
        6: null,
        7: null,
      },
      isEnabled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications & Routines',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Stay on track with reminders and schedules',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),

        // Tab bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: kSNDPigmentGreen.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: kSNDPigmentGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.6),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: const [
              Tab(
                icon: Icon(Icons.notifications_outlined, size: 20),
                text: 'Notifications',
              ),
              Tab(
                icon: Icon(Icons.calendar_today_outlined, size: 20),
                text: 'Routines',
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildNotificationsTab(theme),
              _buildRoutinesTab(theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsTab(ThemeData theme) {
    if (_notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 80,
              color: theme.colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No notifications',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You\'re all caught up!',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.4),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return _buildNotificationCard(notification, theme);
      },
    );
  }

  Widget _buildNotificationCard(AppNotification notification, ThemeData theme) {
    Color notificationColor;
    IconData notificationIcon;

    switch (notification.type) {
      case NotificationType.reminder:
        notificationColor = kSNDPigmentGreen;
        notificationIcon = Icons.alarm;
        break;
      case NotificationType.achievement:
        notificationColor = kSNDYellowGreen;
        notificationIcon = Icons.star;
        break;
      case NotificationType.tip:
        notificationColor = kSNDJade;
        notificationIcon = Icons.lightbulb;
        break;
      case NotificationType.system:
        notificationColor = kSNDCeladon;
        notificationIcon = Icons.info;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.white
            : notificationColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification.isRead
              ? theme.colorScheme.outline.withOpacity(0.2)
              : notificationColor.withOpacity(0.3),
          width: notification.isRead ? 1 : 2,
        ),
        boxShadow: [
          if (!notification.isRead)
            BoxShadow(
              color: notificationColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: notificationColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            notificationIcon,
            color: notificationColor,
            size: 24,
          ),
        ),
        title: Text(
          notification.title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              notification.timeAgo,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontSize: 11,
              ),
            ),
          ],
        ),
        trailing: !notification.isRead
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: notificationColor,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildRoutinesTab(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildRoutineCard(
            theme: theme,
            routine: _guaShaRoutine,
            color: kSNDYellowGreen,
            icon: Icons.spa,
            onRoutineChanged: (newRoutine) {
              setState(() {
                _guaShaRoutine = newRoutine;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildRoutineCard(
            theme: theme,
            routine: _electricStimRoutine,
            color: kSNDPigmentGreen,
            icon: Icons.electric_bolt,
            onRoutineChanged: (newRoutine) {
              setState(() {
                _electricStimRoutine = newRoutine;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineCard({
    required ThemeData theme,
    required model.WeeklyRoutine routine,
    required Color color,
    required IconData icon,
    required Function(model.WeeklyRoutine) onRoutineChanged,
  }) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.1),
                  color.withOpacity(0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        routine.treatmentType,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${routine.scheduledDaysCount} days per week',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: routine.isEnabled,
                  onChanged: (value) {
                    onRoutineChanged(routine.copyWith(isEnabled: value));
                  },
                  activeColor: color,
                ),
              ],
            ),
          ),

          // Days grid
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Days',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(7, (index) {
                    final dayNumber = index + 1;
                    final isScheduled = routine.isDayScheduled(dayNumber);
                    final timeString = routine.getTimeForDay(dayNumber);

                    return GestureDetector(
                      onTap: () {
                        if (isScheduled) {
                          // Remove day
                          final newSchedule = Map<int, model.TimeOfDay?>.from(routine.schedule);
                          newSchedule[dayNumber] = null;
                          onRoutineChanged(routine.copyWith(schedule: newSchedule));
                        } else {
                          // Add day with default time
                          _showTimePicker(context, dayNumber, routine, onRoutineChanged);
                        }
                      },
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isScheduled
                              ? color
                              : theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isScheduled
                                ? color
                                : theme.colorScheme.outline.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              days[index],
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isScheduled
                                    ? Colors.white
                                    : theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            if (isScheduled && timeString != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                timeString,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showTimePicker(
    BuildContext context,
    int dayNumber,
    model.WeeklyRoutine routine,
    Function(model.WeeklyRoutine) onRoutineChanged,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (picked != null) {
      final newSchedule = Map<int, model.TimeOfDay?>.from(routine.schedule);
      newSchedule[dayNumber] = model.TimeOfDay(
        hour: picked.hour,
        minute: picked.minute,
      );
      onRoutineChanged(routine.copyWith(schedule: newSchedule));
    }
  }
}
