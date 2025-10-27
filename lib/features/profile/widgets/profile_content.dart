import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snd_aas/colors.dart';
import 'package:snd_aas/features/profile/models/user_profile.dart';
import 'package:snd_aas/features/profile/models/user_stats.dart';

/// Profile page content with user information and settings
class ProfileContent extends StatefulWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  late UserProfile _profile;
  late UserStats _stats;
  final List<String> _recentPhotos = [];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    _profile = UserProfile(
      id: 'user_123',
      name: 'Alex Johnson',
      email: 'alex.johnson@example.com',
      memberSince: DateTime.now().subtract(const Duration(days: 45)),
      productCode: 'SND-2024-A1B2C3',
      hasFacialParalysis: false,
      medicalNotes: 'No allergies. Sensitive skin on cheeks.',
    );

    _stats = UserStats(
      totalTreatments: 32,
      currentStreak: 5,
      longestStreak: 12,
      totalMinutes: 1280, // ~21 hours
      favoriteTreatment: 'Gua Sha',
    );

    // Mock recent photos
    _recentPhotos.addAll([
      'assets/logo.png',
      'assets/logo.png',
      'assets/logo.png',
      'assets/logo.png',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile Header
          _buildProfileHeader(theme),

          const SizedBox(height: 24),

          // Account Information Section
          _buildSection(
            theme: theme,
            title: 'Account Information',
            icon: Icons.person_outline,
            color: kSNDPigmentGreen,
            child: Column(
              children: [
                _buildInfoRow(
                  theme,
                  'Email',
                  _profile.email,
                  Icons.email_outlined,
                  onTap: () => _showEditDialog(context, 'Email'),
                ),
                _buildDivider(),
                _buildInfoRow(
                  theme,
                  'Password',
                  '••••••••',
                  Icons.lock_outline,
                  onTap: () => _showEditDialog(context, 'Password'),
                ),
                _buildDivider(),
                _buildInfoRow(
                  theme,
                  'Product Code',
                  _profile.productCode ?? 'Not registered',
                  Icons.qr_code,
                  onTap: () => _showProductCodeDialog(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Personal Statistics Section
          _buildSection(
            theme: theme,
            title: 'Personal Statistics',
            icon: Icons.bar_chart,
            color: kSNDYellowGreen,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        theme,
                        _stats.totalTreatments.toString(),
                        'Total Treatments',
                        Icons.spa,
                        kSNDYellowGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        theme,
                        _stats.currentStreak.toString(),
                        'Current Streak',
                        Icons.local_fire_department,
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        theme,
                        _stats.longestStreak.toString(),
                        'Longest Streak',
                        Icons.emoji_events,
                        Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        theme,
                        _stats.totalTimeFormatted,
                        'Total Time',
                        Icons.access_time,
                        kSNDJade,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kSNDCeladon.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: kSNDPigmentGreen),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Favorite Treatment',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _stats.favoriteTreatment,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kSNDPigmentGreen,
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

          const SizedBox(height: 16),

          // Medical Information Section
          _buildSection(
            theme: theme,
            title: 'Medical Information',
            icon: Icons.medical_information_outlined,
            color: kSNDJade,
            child: Column(
              children: [
                _buildInfoRow(
                  theme,
                  'Facial Paralysis',
                  _profile.hasFacialParalysis ? 'Yes' : 'No',
                  Icons.face,
                ),
                _buildDivider(),
                _buildInfoRow(
                  theme,
                  'Medical Notes',
                  _profile.medicalNotes ?? 'None',
                  Icons.note_outlined,
                  onTap: () => _showEditDialog(context, 'Medical Notes'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Progress Photos Quick Access
          _buildSection(
            theme: theme,
            title: 'Progress Photos',
            icon: Icons.photo_library_outlined,
            color: kSNDCeladon,
            child: Column(
              children: [
                if (_recentPhotos.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'No progress photos yet',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _recentPhotos.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 80,
                              margin: EdgeInsets.only(
                                right: index < _recentPhotos.length - 1 ? 8 : 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: kSNDCeladon.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  _recentPhotos[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => context.go('/progress'),
                              icon: const Icon(Icons.grid_view),
                              label: const Text('View All'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: kSNDCeladon,
                                side: BorderSide(color: kSNDCeladon),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _showCompareDialog(context),
                              icon: const Icon(Icons.compare),
                              label: const Text('Compare'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: kSNDCeladon,
                                side: BorderSide(color: kSNDCeladon),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Account Actions
          _buildSection(
            theme: theme,
            title: 'Account Actions',
            icon: Icons.settings_outlined,
            color: theme.colorScheme.error,
            child: Column(
              children: [
                _buildActionRow(
                  theme,
                  'Log Out',
                  Icons.logout,
                  theme.colorScheme.onSurface,
                  onTap: () => _showLogoutDialog(context),
                ),
                _buildDivider(),
                _buildActionRow(
                  theme,
                  'Export My Data',
                  Icons.download,
                  theme.colorScheme.onSurface,
                  onTap: () => _showExportDialog(context),
                ),
                _buildDivider(),
                _buildActionRow(
                  theme,
                  'Delete Account',
                  Icons.delete_forever,
                  theme.colorScheme.error,
                  onTap: () => _showDeleteAccountDialog(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kSNDPigmentGreen.withOpacity(0.1),
            kSNDYellowGreen.withOpacity(0.1),
          ],
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSNDPigmentGreen.withOpacity(0.2),
                  border: Border.all(
                    color: kSNDPigmentGreen,
                    width: 3,
                  ),
                ),
                child: _profile.photoUrl != null
                    ? ClipOval(
                        child: Image.asset(
                          _profile.photoUrl!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 50,
                        color: kSNDPigmentGreen,
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _showEditDialog(context, 'Profile Photo'),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kSNDPigmentGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            _profile.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          // Member since
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 4),
              Text(
                'Member for ${_profile.memberSinceFormatted}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Edit Profile Button
          OutlinedButton.icon(
            onPressed: () => _showEditDialog(context, 'Profile Name'),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
            style: OutlinedButton.styleFrom(
              foregroundColor: kSNDPigmentGreen,
              side: BorderSide(color: kSNDPigmentGreen, width: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required ThemeData theme,
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    ThemeData theme,
    String label,
    String value,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: kSNDJade),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurface.withOpacity(0.3),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionRow(
    ThemeData theme,
    String label,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: color.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    ThemeData theme,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.2),
      height: 1,
    );
  }

  void _showEditDialog(BuildContext context, String field) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          decoration: InputDecoration(
            labelText: field,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$field updated successfully')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showProductCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Product Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_profile.productCode ?? 'No product code registered'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.qr_code, size: 100),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCompareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Compare Photos'),
        content: const Text('Photo comparison feature coming soon'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('Your data will be exported as a ZIP file containing all photos and treatment history.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export started. You will receive an email when ready.')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('This action cannot be undone. All your data, photos, and treatment history will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
