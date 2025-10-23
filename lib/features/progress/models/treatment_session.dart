/// Model for a treatment session
class TreatmentSession {
  final String id;
  final DateTime dateTime;
  final String treatmentType; // 'Gua Sha' or 'Electric Stimulator'
  final String? notes;
  final List<String> photosPaths;

  TreatmentSession({
    required this.id,
    required this.dateTime,
    required this.treatmentType,
    this.notes,
    this.photosPaths = const [],
  });

  // Helper to get time string
  String get timeString {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Helper to check if session has photos
  bool get hasPhotos => photosPaths.isNotEmpty;

  // Helper to check if session has notes
  bool get hasNotes => notes != null && notes!.isNotEmpty;
}
