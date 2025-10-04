import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart' as SNDColors;

class GreetingPage extends StatefulWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GreetingPageState();
  }
}

class _GreetingPageState extends State<GreetingPage>
    with TickerProviderStateMixin {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment(-1, 0),
    end: Alignment.bottomRight,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  Widget _buildFloatingCircle(
    double size,
    Color color,
    AlignmentGeometry alignment,
  ) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.2), // translucent
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [

              Colors.white,
              Color(0xFFd6e8b7),
              Color(0xFFd3e8ac),
              //SNDColors.kSNDYellowGreen, // deep blue
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Stack(
                    children: [

                      _buildFloatingCircle(
                        75,
                        theme.colorScheme.tertiary,
                        Alignment(-.5, .5),
                      ),
                      _buildFloatingCircle(
                        250,
                        theme.colorScheme.secondary,
                        Alignment(-1.8, 1.1),
                      ),
                      _buildFloatingCircle(
                        50,
                        theme.colorScheme.primary,
                        Alignment(-.8, -.6),
                      ),
                      _buildFloatingCircle(
                        300,
                        theme.colorScheme.tertiary,
                        Alignment(3.0, -1.2),
                      ),
                    ],
                  );
                },
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/logo.png',
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "SND ",
                                style: theme.textTheme.displayMedium,
                              ),
                              Text(
                                "Anti-Aging System",
                                style: theme.textTheme.titleMedium,
                              ),
                              SizedBox(height: size.height * .1),
                              SizedBox(
                                width: size.width * .5,

                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Login"),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: size.width * .5,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text("Register Product"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
