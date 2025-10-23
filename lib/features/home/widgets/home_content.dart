import 'package:flutter/material.dart';
import 'package:snd_aas/features/home/widgets/treatment_flow_card.dart';
import 'package:snd_aas/colors.dart';

/// Home page content with welcome message and treatment flow options
class HomeContent extends StatefulWidget {
  const HomeContent({
    Key? key,
    required this.onGuaShaPressed,
    required this.onElectricStimulatorPressed,
    this.userName = 'User',
  }) : super(key: key);

  final VoidCallback onGuaShaPressed;
  final VoidCallback onElectricStimulatorPressed;
  final String userName;

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Create staggered animations for each section
    final sectionCount = 3;
    _fadeAnimations = List.generate(
      sectionCount,
      (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.15,
            0.4 + (index * 0.15),
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _slideAnimations = List.generate(
      sectionCount,
      (index) => Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.15,
            0.4 + (index * 0.15),
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome section with animation
          FadeTransition(
            opacity: _fadeAnimations[0],
            child: SlideTransition(
              position: _slideAnimations[0],
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${_getTimeBasedGreeting()}, ${widget.userName}!',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ready for your next session?',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Treatment flows section with animation
          FadeTransition(
            opacity: _fadeAnimations[1],
            child: SlideTransition(
              position: _slideAnimations[1],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Treatments',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TreatmentFlowCard(
                            title: 'Gua Sha',
                            description: 'Takes about 20 minutes',
                            icon: Icons.spa,
                            accentColor: kSNDYellowGreen,
                            onTap: widget.onGuaShaPressed,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TreatmentFlowCard(
                            title: 'Electric Stimulator',
                            description: 'Takes about 45 minutes',
                            icon: Icons.electric_bolt,
                            accentColor: kSNDPigmentGreen,
                            onTap: widget.onElectricStimulatorPressed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Quick tips section with animation
          FadeTransition(
            opacity: _fadeAnimations[2],
            child: SlideTransition(
              position: _slideAnimations[2],
              child: Container(
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
            ),
          ),
        ],
      ),
    );
  }
}
