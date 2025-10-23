import 'package:flutter/material.dart';
import 'package:snd_aas/features/home/widgets/treatment_flow_card.dart';
import 'package:snd_aas/colors.dart';

/// Home page content with welcome message and treatment flow options
class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.onQuickTreatmentPressed,
    required this.onDeepTreatmentPressed,
    this.userName = 'User',
  }) : super(key: key);

  final VoidCallback onQuickTreatmentPressed;
  final VoidCallback onDeepTreatmentPressed;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome section
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 60,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome back, $userName!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose your treatment',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Treatment flows section
          Text(
            'Available Treatments',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),

          // Treatment cards in a row
          Row(
            children: [
              Expanded(
                child: TreatmentFlowCard(
                  title: 'Gua Sha',
                  description: 'Takes about 20 minutes',
                  icon: Icons.spa,
                  accentColor: kSNDYellowGreen,
                  onTap: onQuickTreatmentPressed,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TreatmentFlowCard(
                  title: 'Electric Stimulator',
                  description: 'Takes about 45 minutes',
                  icon: Icons.electric_bolt,
                  accentColor: kSNDPigmentGreen,
                  onTap: onDeepTreatmentPressed,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Quick tips section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kSNDCeladon.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: kSNDCeladon,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: kSNDJade,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tip of the Day',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kSNDJade,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Consistency is key! Try to complete at least 3 treatments per week for best results.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
