import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';

/// Photo comparison page with side-by-side and overlay views
class PhotoComparisonPage extends StatefulWidget {
  const PhotoComparisonPage({Key? key}) : super(key: key);

  @override
  State<PhotoComparisonPage> createState() => _PhotoComparisonPageState();
}

class _PhotoComparisonPageState extends State<PhotoComparisonPage> {
  DateTime? _beforeDate;
  DateTime? _afterDate;
  String? _beforePhoto;
  String? _afterPhoto;
  bool _isOverlayMode = false;
  double _overlayPosition = 0.5;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    // Mock data - simulate before and after photos
    _beforeDate = DateTime.now().subtract(const Duration(days: 30));
    _afterDate = DateTime.now();
    _beforePhoto = 'assets/tempImage.png';
    _afterPhoto = 'assets/tempImage.png';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Photos'),
        actions: [
          IconButton(
            icon: Icon(_isOverlayMode ? Icons.view_column : Icons.layers),
            onPressed: () {
              setState(() {
                _isOverlayMode = !_isOverlayMode;
              });
            },
            tooltip: _isOverlayMode ? 'Side by Side' : 'Overlay',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Date selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildDateSelector(
                      theme,
                      'Before',
                      _beforeDate,
                      kSNDYellowGreen,
                      () => _selectDate(context, true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.arrow_forward, color: kSNDPigmentGreen),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDateSelector(
                      theme,
                      'After',
                      _afterDate,
                      kSNDPigmentGreen,
                      () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),
            ),

            // Comparison view
            Expanded(
              child: _beforePhoto != null && _afterPhoto != null
                  ? _isOverlayMode
                      ? _buildOverlayView(theme)
                      : _buildSideBySideView(theme)
                  : _buildEmptyState(theme),
            ),

            // Controls
            if (_beforePhoto != null && _afterPhoto != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (_isOverlayMode)
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.opacity, color: kSNDJade, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Overlay Position',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: kSNDJade,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: _overlayPosition,
                            onChanged: (value) {
                              setState(() {
                                _overlayPosition = value;
                              });
                            },
                            activeColor: kSNDPigmentGreen,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    Row(
                      children: [
                        Icon(Icons.zoom_in, color: kSNDJade, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Zoom: ${(_scale * 100).toInt()}%',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: kSNDJade,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: _scale,
                            min: 1.0,
                            max: 3.0,
                            onChanged: (value) {
                              setState(() {
                                _scale = value;
                              });
                            },
                            activeColor: kSNDPigmentGreen,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            setState(() {
                              _scale = 1.0;
                              _overlayPosition = 0.5;
                            });
                          },
                          tooltip: 'Reset',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(
    ThemeData theme,
    String label,
    DateTime? date,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null
                      ? '${date.day}/${date.month}/${date.year}'
                      : 'Select date',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Icon(Icons.calendar_today, color: color, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideBySideView(ThemeData theme) {
    return InteractiveViewer(
      minScale: 1.0,
      maxScale: 3.0,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: kSNDYellowGreen, width: 3),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _beforePhoto!,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: kSNDYellowGreen,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'BEFORE',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 2,
            color: theme.colorScheme.outline,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: kSNDPigmentGreen, width: 3),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _afterPhoto!,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: kSNDPigmentGreen,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'AFTER',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayView(ThemeData theme) {
    return InteractiveViewer(
      minScale: 1.0,
      maxScale: 3.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // After image (background)
          Image.asset(
            _afterPhoto!,
            fit: BoxFit.contain,
          ),
          // Before image (clipped)
          ClipRect(
            clipper: _SlideClipper(_overlayPosition),
            child: Image.asset(
              _beforePhoto!,
              fit: BoxFit.contain,
            ),
          ),
          // Slider divider
          Positioned(
            left: MediaQuery.of(context).size.width * _overlayPosition - 2,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.drag_handle,
                    color: kSNDPigmentGreen,
                  ),
                ),
              ),
            ),
          ),
          // Labels
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kSNDYellowGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'BEFORE',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kSNDPigmentGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'AFTER',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.compare,
            size: 80,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Select dates to compare',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose before and after dates\nto see your progress',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isBefore) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: isBefore ? kSNDYellowGreen : kSNDPigmentGreen,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isBefore) {
          _beforeDate = picked;
          // TODO: Load photo for this date
        } else {
          _afterDate = picked;
          // TODO: Load photo for this date
        }
      });
    }
  }
}

class _SlideClipper extends CustomClipper<Rect> {
  final double position;

  _SlideClipper(this.position);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * position, size.height);
  }

  @override
  bool shouldReclip(_SlideClipper oldClipper) {
    return oldClipper.position != position;
  }
}
