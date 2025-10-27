/// Model for user profile information
class UserProfile {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final DateTime memberSince;
  final String? productCode;
  final bool hasFacialParalysis;
  final String? medicalNotes;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.memberSince,
    this.productCode,
    this.hasFacialParalysis = false,
    this.medicalNotes,
  });

  String get memberSinceFormatted {
    final now = DateTime.now();
    final difference = now.difference(memberSince);

    if (difference.inDays < 30) {
      return '${difference.inDays} days';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'}';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'}';
    }
  }
}
