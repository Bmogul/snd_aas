import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:snd_aas/colors.dart';
import 'package:snd_aas/features/progress/models/treatment_session.dart';

/// Progress page content with calendar and treatment summaries
class ProgressContent extends StatefulWidget {
  const ProgressContent({Key? key}) : super(key: key);

  @override
  State<ProgressContent> createState() => _ProgressContentState();
}

class _ProgressContentState extends State<ProgressContent> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<TreatmentSession>> _treatmentSessions = {};

  @override
  void initState() {
    super.initState();
    _loadMockData();
    _selectedDay = _focusedDay;
  }

  void _loadMockData() {
    // Mock treatment sessions
    final now = DateTime.now();

    // Add some treatment sessions in the past
    for (int i = 0; i < 10; i++) {
      final date = DateTime(now.year, now.month, now.day - (i * 3));
      final normalizedDate = DateTime(date.year, date.month, date.day);

      // Sometimes add multiple sessions per day
      final sessions = <TreatmentSession>[];

      // Morning session
      sessions.add(TreatmentSession(
        id: 'session_${i}_1',
        dateTime: DateTime(date.year, date.month, date.day, 9, 30),
        treatmentType: i % 2 == 0 ? 'Gua Sha' : 'Electric Stimulator',
        notes: i % 3 == 0 ? 'Felt great! Noticed reduced tension around jaw area.' : null,
        photosPaths: i % 2 == 0 ? ['assets/tempImage.png'] : [],
      ));

      // Evening session (sometimes)
      if (i % 4 == 0) {
        sessions.add(TreatmentSession(
          id: 'session_${i}_2',
          dateTime: DateTime(date.year, date.month, date.day, 18, 45),
          treatmentType: 'Gua Sha',
          notes: 'Second session of the day. Feeling more relaxed.',
          photosPaths: ['assets/tempImage.png'],
        ));
      }

      _treatmentSessions[normalizedDate] = sessions;
    }
  }

  List<TreatmentSession> _getSessionsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _treatmentSessions[normalizedDay] ?? [];
  }

  bool _hasTreatmentOnDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _treatmentSessions.containsKey(normalizedDay);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sessions = _selectedDay != null ? _getSessionsForDay(_selectedDay!) : [];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progress Tracker',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Track your treatment history and progress photos',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          // Calendar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: kSNDPigmentGreen.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: kSNDYellowGreen.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: kSNDPigmentGreen,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: kSNDJade,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ) ?? const TextStyle(),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: theme.colorScheme.primary,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.primary,
                ),
              ),
              eventLoader: (day) {
                return _hasTreatmentOnDay(day) ? ['treatment'] : [];
              },
            ),
          ),

          const SizedBox(height: 24),

          // Selected date info
          if (_selectedDay != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: kSNDPigmentGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (_hasTreatmentOnDay(_selectedDay!)) ...[
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: kSNDJade.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Treatment Day',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: kSNDJade,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

          const SizedBox(height: 16),

          // Treatment sessions section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Treatment Sessions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Sessions list
          if (sessions.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: kSNDCeladon.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: kSNDCeladon.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 60,
                      color: theme.colorScheme.onSurface.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No treatments on this date',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return _buildTreatmentSessionCard(context, session, theme);
              },
            ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTreatmentSessionCard(
    BuildContext context,
    TreatmentSession session,
    ThemeData theme,
  ) {
    final sessionColor = session.treatmentType == 'Gua Sha'
        ? kSNDYellowGreen
        : kSNDPigmentGreen;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: sessionColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: sessionColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with time and treatment type
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  sessionColor.withOpacity(0.1),
                  sessionColor.withOpacity(0.05),
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sessionColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    session.treatmentType == 'Gua Sha'
                        ? Icons.spa
                        : Icons.electric_bolt,
                    color: sessionColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.treatmentType,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: sessionColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            session.timeString,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Notes section
          if (session.hasNotes)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.note_outlined,
                        size: 18,
                        color: kSNDJade,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Notes',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kSNDJade,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kSNDCeladon.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      session.notes!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Photos section
          if (session.hasPhotos)
            Padding(
              padding: EdgeInsets.fromLTRB(16, session.hasNotes ? 0 : 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.photo_camera_outlined,
                        size: 18,
                        color: kSNDJade,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Progress Photos',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kSNDJade,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: session.photosPaths.length,
                      itemBuilder: (context, photoIndex) {
                        return GestureDetector(
                          onTap: () {
                            _showPhotoDialog(context, session.photosPaths[photoIndex]);
                          },
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(
                              right: photoIndex < session.photosPaths.length - 1 ? 12 : 0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: sessionColor.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    session.photosPaths[photoIndex],
                                    fit: BoxFit.cover,
                                  ),
                                  // Zoom indicator
                                  Positioned(
                                    bottom: 4,
                                    right: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.zoom_in,
                                        color: sessionColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

          // Empty state if no notes or photos
          if (!session.hasNotes && !session.hasPhotos)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'No additional details',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.4),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showPhotoDialog(BuildContext context, String photoPath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  photoPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
