/// Model for user treatment statistics
class UserStats {
  final int totalTreatments;
  final int currentStreak;
  final int longestStreak;
  final int totalMinutes;
  final String favoriteTreatment;

  UserStats({
    required this.totalTreatments,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalMinutes,
    required this.favoriteTreatment,
  });

  String get totalTimeFormatted {
    if (totalMinutes < 60) {
      return '$totalMinutes min';
    } else {
      final hours = (totalMinutes / 60).floor();
      final minutes = totalMinutes % 60;
      if (minutes == 0) {
        return '$hours ${hours == 1 ? 'hour' : 'hours'}';
      }
      return '$hours ${hours == 1 ? 'hr' : 'hrs'} $minutes min';
    }
  }
}
