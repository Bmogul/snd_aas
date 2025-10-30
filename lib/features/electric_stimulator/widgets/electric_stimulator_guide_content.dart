import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';

/// Content widget for the Electric Stimulator guide page
class ElectricStimulatorGuideContent extends StatefulWidget {
  const ElectricStimulatorGuideContent({Key? key}) : super(key: key);

  @override
  State<ElectricStimulatorGuideContent> createState() =>
      _ElectricStimulatorGuideContentState();
}

class _ElectricStimulatorGuideContentState
    extends State<ElectricStimulatorGuideContent> {
  String _selectedRoutine = 'full'; // 'full', 'left', 'right'

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
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
                  kSNDPigmentGreen.withOpacity(0.2),
                  kSNDPigmentGreen.withOpacity(0.1),
                ],
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                  color: kSNDPigmentGreen,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/es.png',
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Electric Stimulator',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: kSNDPigmentGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Microcurrent Facial Therapy',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Treatment Duration Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kSNDCeladon.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: kSNDCeladon.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: kSNDCeladon,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Treatment Duration',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kSNDCeladon,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Approximately 45 minutes',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Routine Selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Treatment Routine',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kSNDPigmentGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Choose the routine that matches your needs',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 16),

                // Full Routine Option
                _buildRoutineOption(
                  theme,
                  'full',
                  'ES Full Routine',
                  'Complete facial treatment for beauty and wellness',
                  Icons.face,
                ),
                const SizedBox(height: 12),

                // Left Side Option
                _buildRoutineOption(
                  theme,
                  'left',
                  'Facial Paralysis (Left)',
                  'Targeted treatment for left side facial paralysis',
                  Icons.arrow_back,
                ),
                const SizedBox(height: 12),

                // Right Side Option
                _buildRoutineOption(
                  theme,
                  'right',
                  'Facial Paralysis (Right)',
                  'Targeted treatment for right side facial paralysis',
                  Icons.arrow_forward,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Start Treatment Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to treatment flow with selected routine
                  final routineName = _selectedRoutine == 'full'
                      ? 'ES Full Routine'
                      : _selectedRoutine == 'left'
                          ? 'Facial Paralysis (Left)'
                          : 'Facial Paralysis (Right)';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Starting $routineName - Coming soon!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSNDPigmentGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_arrow, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      'Start Treatment',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // What It Is Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: kSNDPigmentGreen.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kSNDPigmentGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.info_outline,
                          color: kSNDPigmentGreen,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'What It Is',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kSNDPigmentGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'An electric facial stimulator (also called microcurrent device or EMS facial tool) uses low-level electrical currents to stimulate facial muscles and skin. These gentle pulses mimic the body\'s natural electrical signals to tone muscles and boost cellular activity.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.8),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Benefits Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kSNDPigmentGreen.withOpacity(0.1),
                    kSNDJade.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: kSNDPigmentGreen.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kSNDPigmentGreen.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.favorite_outline,
                          color: kSNDPigmentGreen,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Benefits',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kSNDPigmentGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildBenefit(
                    theme,
                    Icons.face_retouching_natural,
                    'Tones and lifts facial muscles (natural "face lift")',
                  ),
                  const SizedBox(height: 16),
                  _buildBenefit(
                    theme,
                    Icons.auto_awesome,
                    'Improves skin firmness and elasticity',
                  ),
                  const SizedBox(height: 16),
                  _buildBenefit(
                    theme,
                    Icons.opacity,
                    'Enhances product absorption',
                  ),
                  const SizedBox(height: 16),
                  _buildBenefit(
                    theme,
                    Icons.stars,
                    'Boosts collagen and elastin production',
                  ),
                  const SizedBox(height: 16),
                  _buildBenefit(
                    theme,
                    Icons.trending_down,
                    'Reduces appearance of fine lines and wrinkles',
                  ),
                  const SizedBox(height: 16),
                  _buildBenefit(
                    theme,
                    Icons.face,
                    'Improves facial contour definition',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildRoutineOption(
    ThemeData theme,
    String value,
    String title,
    String description,
    IconData icon,
  ) {
    final isSelected = _selectedRoutine == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedRoutine = value;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? kSNDPigmentGreen.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? kSNDPigmentGreen
                : kSNDPigmentGreen.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? kSNDPigmentGreen.withOpacity(0.2)
                    : kSNDPigmentGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: kSNDPigmentGreen,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? kSNDPigmentGreen
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: kSNDPigmentGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefit(ThemeData theme, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kSNDPigmentGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: kSNDPigmentGreen,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
