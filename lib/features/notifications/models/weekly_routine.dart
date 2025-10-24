/// Model for weekly treatment routine
class WeeklyRoutine {
  final String treatmentType; // 'Gua Sha' or 'Electric Stimulator'
  final Map<int, TimeOfDay?> schedule; // Day of week (1-7) -> Time
  final bool isEnabled;

  WeeklyRoutine({
    required this.treatmentType,
    required this.schedule,
    this.isEnabled = true,
  });

  /// Check if a specific day is scheduled
  bool isDayScheduled(int dayOfWeek) {
    return schedule[dayOfWeek] != null;
  }

  /// Get scheduled days count
  int get scheduledDaysCount {
    return schedule.values.where((time) => time != null).length;
  }

  /// Get formatted time for a day
  String? getTimeForDay(int dayOfWeek) {
    final time = schedule[dayOfWeek];
    if (time == null) return null;

    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Create a copy with modifications
  WeeklyRoutine copyWith({
    String? treatmentType,
    Map<int, TimeOfDay?>? schedule,
    bool? isEnabled,
  }) {
    return WeeklyRoutine(
      treatmentType: treatmentType ?? this.treatmentType,
      schedule: schedule ?? this.schedule,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({
    required this.hour,
    required this.minute,
  });
}
