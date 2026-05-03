# SND Anti-Aging System - Development Roadmap

This document tracks all unimplemented features and planned development work, organized by milestone.

## 📋 Table of Contents
- [Milestone 1: Face Detection Prototype and Navigation/UI Flows](#milestone-1-face-detection-prototype-and-navigationui-flows)
- [Milestone 2: Electric Stim and Gua Sha Treatment Workflows](#milestone-2-electric-stim-and-gua-sha-treatment-workflows)
- [Milestone 3: Backend Infrastructure, Login System, Cloud Sync](#milestone-3-backend-infrastructure-login-system-cloud-sync)
- [Milestone 4: Routine Scheduler, Reminder Notifications, Photo Gallery](#milestone-4-routine-scheduler-reminder-notifications-photo-gallery)

---

## Milestone 1: Face Detection Prototype and Navigation/UI Flows

### 🎯 Status: Partially Complete
**UI/Navigation**: ✅ Complete
**Face Detection**: ⏳ Not Started

### Face Detection Features

#### 1. Real-Time Face Detection During Photo Capture
**Location**: `lib/features/treatment/widgets/post_treatment_form_content.dart:35-59`

**Tasks**:
- [ ] Integrate face detection ML model (e.g., Google ML Kit, TensorFlow Lite)
- [ ] Implement real-time face detection overlay on camera view
- [ ] Verify face is detected in frame before allowing capture
- [ ] Check proper lighting conditions and provide feedback
- [ ] Guide user to optimal photo angle and distance
- [ ] Validate face alignment and positioning
- [ ] Show visual guides (face outline, positioning hints)

**Technical Requirements**:
- Package: `google_ml_kit` or `tflite_flutter`
- Custom camera implementation with CameraController
- Real-time frame processing
- Face detection confidence threshold (>0.85 recommended)

#### 2. Post-Capture Face Validation
**Location**: `lib/features/treatment/widgets/post_treatment_form_content.dart:49-59`

**Tasks**:
- [ ] Verify captured image contains a valid face
- [ ] Extract facial landmarks (68-point model)
- [ ] Store facial metrics for progress tracking:
  - Face oval dimensions
  - Eye positions and distances
  - Nose position
  - Mouth corners
  - Jawline contour points
- [ ] Reject photos that don't meet quality standards
- [ ] Calculate face symmetry scores
- [ ] Store landmark data in JSON format with photo

**Data Structure**:
```dart
class FacialMetrics {
  final String photoId;
  final DateTime timestamp;
  final List<FaceLandmark> landmarks;
  final Map<String, double> measurements;
  final double symmetryScore;
  final double qualityScore;
}
```

#### 3. Navigation/UI Improvements
**Location**: Throughout app

**Tasks**:
- [ ] Add loading states for async operations
- [ ] Implement error boundaries for camera failures
- [ ] Add onboarding tour for first-time users
- [ ] Create help/info overlays for complex features
- [ ] Add haptic feedback for important actions
- [ ] Implement gesture controls (swipe to navigate)

---

## Milestone 2: Electric Stim and Gua Sha Treatment Workflows

### 🎯 Status: Not Started
**Current State**: Only guide pages exist, no step-by-step workflows

### Gua Sha Treatment Workflow

#### 1. Step-by-Step Guided Flow
**Location**: `lib/features/gua_sha/widgets/gua_sha_guide_content.dart:5-14`

**Tasks**:
- [ ] Create multi-step treatment wizard (8-10 steps)
- [ ] Design step pages for each facial zone:
  1. Forehead
  2. Between eyebrows
  3. Eye area (crow's feet)
  4. Cheekbones
  5. Jawline
  6. Chin
  7. Neck
  8. Décolletage (optional)
- [ ] Add animated GIF/video demonstrations for each step
- [ ] Show stroke direction with animated arrows
- [ ] Indicate pressure level (light, medium, firm)
- [ ] Add timer for each zone (2-3 minutes per area)
- [ ] Implement progress bar showing workflow completion
- [ ] Add pause/resume functionality
- [ ] Save progress if user exits mid-treatment

**Technical Implementation**:
```dart
class GuaShaWorkflowPage extends StatefulWidget {
  // PageView with step pages
  // Timer for each step
  // Progress indicator
  // Skip/Previous/Next navigation
}

class GuaShaStep {
  final String zone;
  final String instructions;
  final String animationAsset;
  final Duration duration;
  final String pressureLevel;
  final List<String> tips;
}
```

#### 2. Visual Guides and Assets
**Tasks**:
- [ ] Create anatomical diagrams showing treatment zones
- [ ] Design stroke direction animations
- [ ] Add pressure visualization indicators
- [ ] Include before/after reference images
- [ ] Add audio instructions (optional)

### Electric Stimulator Treatment Workflow

#### 1. Routine-Specific Workflows
**Location**: `lib/features/electric_stimulator/widgets/electric_stimulator_guide_content.dart:5-17`

**Tasks**:
- [ ] Implement three separate workflow types:
  - Full Routine (8 zones, 45 minutes)
  - Facial Paralysis Left (4 zones, 25 minutes)
  - Facial Paralysis Right (4 zones, 25 minutes)
- [ ] Create electrode placement diagrams for each zone
- [ ] Add anatomical overlays showing muscle groups
- [ ] Implement zone-specific timers (3-5 minutes each)
- [ ] Show intensity level recommendations
- [ ] Add rest period timers between zones (30 seconds)
- [ ] Implement safety checks and contraindications warning
- [ ] Add audio/vibration cues for zone completion
- [ ] Track total treatment duration with countdown

#### 2. Full Routine Zones (45 minutes total)
**Tasks**:
- [ ] Zone 1: Forehead (frontalis muscle) - 5 min
- [ ] Zone 2: Eye area (orbicularis oculi) - 5 min
- [ ] Zone 3: Cheeks (zygomaticus major/minor) - 6 min
- [ ] Zone 4: Nasolabial folds (levator labii) - 5 min
- [ ] Zone 5: Jawline (masseter muscle) - 6 min
- [ ] Zone 6: Chin (mentalis muscle) - 5 min
- [ ] Zone 7: Neck (platysma muscle) - 6 min
- [ ] Zone 8: Temple area (temporalis) - 5 min
- [ ] Rest periods between zones - 2 min total

#### 3. Safety Features
**Tasks**:
- [ ] Pre-treatment health questionnaire
- [ ] Contraindications checker:
  - Pacemaker warning
  - Pregnancy warning
  - Seizure history warning
  - Open wounds/skin conditions
- [ ] Intensity level safety limits
- [ ] Emergency stop button
- [ ] Session timeout protection

**Technical Implementation**:
```dart
class ElectricStimWorkflowPage extends StatefulWidget {
  final String routineType; // 'full', 'left', 'right'
  // Zone management
  // Timer controllers
  // Intensity tracking
  // Safety checks
}

class TreatmentZone {
  final String name;
  final String muscleGroup;
  final Duration duration;
  final String placementDiagram;
  final List<String> instructions;
  final IntensityRange recommendedIntensity;
}
```

#### 4. Workflow UI Components
**Tasks**:
- [ ] Create countdown timer widget
- [ ] Design intensity level selector (1-10 scale)
- [ ] Build zone completion checklist
- [ ] Add treatment summary screen
- [ ] Implement session pause/resume
- [ ] Add emergency exit with confirmation

---

## Milestone 3: Backend Infrastructure, Login System, Cloud Sync

### 🎯 Status: UI Only (No Backend)
**Current State**: Mock authentication, no data persistence

### Authentication System

#### 1. Email/Password Authentication
**Location**: `lib/features/auth/widgets/login_form.dart:35-50`

**Tasks**:
- [ ] Choose backend (Firebase Auth recommended or custom)
- [ ] Integrate authentication SDK
- [ ] Implement email/password login
- [ ] Add email verification flow
- [ ] Implement password reset functionality
- [ ] Add "forgot password" email sending
- [ ] Store auth tokens securely (flutter_secure_storage)
- [ ] Implement session management
- [ ] Add auto-logout on token expiration
- [ ] Handle authentication errors with user-friendly messages

#### 2. Social Authentication
**Location**: `lib/features/auth/widgets/login_form.dart`

**Tasks**:
- [ ] Implement Google Sign-In
  - OAuth 2.0 integration
  - Profile data retrieval
  - Token refresh handling
- [ ] Implement Apple Sign-In
  - Sign in with Apple credential
  - Handle privacy requirements
- [ ] Link social accounts to existing accounts
- [ ] Handle account conflicts

#### 3. User Registration
**Tasks**:
- [ ] Create account with email/password
- [ ] Validate email format and password strength
- [ ] Send verification email
- [ ] Create user profile in database
- [ ] Handle duplicate email errors
- [ ] Add terms of service acceptance

### Database & Cloud Storage

#### 1. User Data Schema
**Tasks**:
- [ ] Design Firestore/SQL database schema
- [ ] User profile collection:
  ```json
  {
    "userId": "string",
    "email": "string",
    "name": "string",
    "photoUrl": "string",
    "createdAt": "timestamp",
    "lastLogin": "timestamp",
    "preferences": {
      "notificationsEnabled": "boolean",
      "reminderTime": "time",
      "theme": "string"
    },
    "statistics": {
      "totalTreatments": "number",
      "currentStreak": "number",
      "longestStreak": "number"
    }
  }
  ```

#### 2. Treatment Sessions Collection
**Tasks**:
- [ ] Create treatment_sessions collection
  ```json
  {
    "sessionId": "string",
    "userId": "string",
    "treatmentType": "guaSha | electricStim",
    "routineName": "string",
    "date": "timestamp",
    "duration": "number",
    "notes": "string",
    "photoUrl": "string",
    "photoThumbnailUrl": "string",
    "facialMetrics": {
      "landmarks": "array",
      "measurements": "object"
    },
    "completedSteps": "array",
    "rating": "number"
  }
  ```

#### 3. Cloud Storage for Photos
**Tasks**:
- [ ] Set up Firebase Storage or AWS S3
- [ ] Implement photo upload with progress tracking
- [ ] Generate thumbnails for gallery view
- [ ] Implement compression before upload
- [ ] Add photo deletion from cloud
- [ ] Implement secure URL generation with expiry
- [ ] Handle upload failures and retry logic
- [ ] Add offline queue for uploads

#### 4. Data Synchronization
**Location**: `lib/features/home/widgets/home_content.dart:30-36`

**Tasks**:
- [ ] Implement real-time sync with Firestore listeners
- [ ] Add local database caching (sqflite or Hive)
- [ ] Sync user profile data on login
- [ ] Load treatment history from cloud
- [ ] Fetch progress photos
- [ ] Update notification preferences
- [ ] Handle offline mode gracefully
- [ ] Implement conflict resolution for offline changes
- [ ] Add sync status indicators in UI

#### 5. Data Persistence
**Location**: `lib/features/treatment/widgets/post_treatment_form_content.dart:147-175`

**Tasks**:
- [ ] Save treatment session to cloud on form submit
- [ ] Upload progress photo to cloud storage
- [ ] Store session data in local database
- [ ] Update user statistics (total treatments, streaks)
- [ ] Trigger notification scheduling updates
- [ ] Handle save failures with retry mechanism
- [ ] Show save progress to user

**Location**: `lib/features/progress/widgets/progress_content.dart:29-34`

**Tasks**:
- [ ] Load all treatment sessions from database
- [ ] Fetch photos and notes for selected dates
- [ ] Calculate statistics (total count, streaks, consistency rate)
- [ ] Cache data locally for fast access
- [ ] Implement pagination for large datasets
- [ ] Add pull-to-refresh functionality

### API Layer

#### 1. API Service Structure
**Tasks**:
- [ ] Create API service classes
  ```dart
  class AuthService {
    Future<User> signIn(String email, String password);
    Future<User> signUp(String email, String password);
    Future<void> signOut();
    Future<void> resetPassword(String email);
  }

  class TreatmentService {
    Future<void> saveTreatmentSession(TreatmentSession session);
    Future<List<TreatmentSession>> getTreatmentHistory(String userId);
    Future<void> deleteTreatmentSession(String sessionId);
  }

  class StorageService {
    Future<String> uploadPhoto(File photo, String userId);
    Future<void> deletePhoto(String photoUrl);
    Future<File> downloadPhoto(String photoUrl);
  }
  ```

#### 2. Error Handling
**Tasks**:
- [ ] Implement global error handler
- [ ] Add retry logic for network failures
- [ ] Show user-friendly error messages
- [ ] Log errors to analytics service
- [ ] Handle rate limiting and throttling

### Security

#### 1. Data Protection
**Tasks**:
- [ ] Implement Firestore security rules
- [ ] Set up Storage bucket security rules
- [ ] Validate user permissions on all operations
- [ ] Encrypt sensitive data at rest
- [ ] Use HTTPS for all API calls
- [ ] Implement rate limiting

#### 2. Privacy Compliance
**Tasks**:
- [ ] Add privacy policy acceptance
- [ ] Implement data export functionality (GDPR)
- [ ] Add account deletion with data purge
- [ ] Handle user data requests
- [ ] Implement audit logging

---

## Milestone 4: Routine Scheduler, Reminder Notifications, Photo Gallery

### 🎯 Status: UI Mockup Only
**Current State**: Mock data, no actual scheduling or notifications

### Routine Scheduler

#### 1. Weekly Routine Setup
**Location**: `lib/features/notifications/widgets/notifications_content.dart:36-44`

**Tasks**:
- [ ] Create routine scheduling UI
- [ ] Allow users to select days of week for each treatment type
- [ ] Set preferred time for each treatment day
- [ ] Support multiple treatments per day
- [ ] Add routine templates (3x/week, daily, alternate days)
- [ ] Save routine preferences to database
- [ ] Sync routine settings across devices
- [ ] Add routine edit and delete functionality
- [ ] Show next scheduled treatment on home screen

**Technical Implementation**:
```dart
class RoutineScheduler {
  Future<void> scheduleRoutine(WeeklyRoutine routine);
  Future<void> updateRoutine(String routineId, WeeklyRoutine routine);
  Future<void> deleteRoutine(String routineId);
  Future<List<ScheduledTreatment>> getUpcomingTreatments();
}

class WeeklyRoutine {
  final String id;
  final String userId;
  final String treatmentType;
  final Map<String, TimeOfDay> scheduledDays; // {monday: 09:00, wednesday: 09:00}
  final bool notificationsEnabled;
  final int reminderMinutesBefore;
}
```

#### 2. Smart Scheduling Features
**Tasks**:
- [ ] Suggest optimal treatment times based on history
- [ ] Detect and suggest streak maintenance
- [ ] Recommend rest days to avoid overtreatment
- [ ] Adjust schedule for holidays/vacations
- [ ] Add "skip this week" functionality
- [ ] Track schedule adherence rate

### Reminder Notifications

#### 1. Local Notifications Setup
**Location**: `lib/features/notifications/widgets/notifications_content.dart:7-18`

**Tasks**:
- [ ] Integrate flutter_local_notifications package
- [ ] Request notification permissions (iOS/Android)
- [ ] Initialize notification channels (Android)
- [ ] Set up notification icons and sounds
- [ ] Configure notification actions

#### 2. Notification Scheduling
**Tasks**:
- [ ] Schedule notifications based on weekly routines
- [ ] Send reminder X minutes before scheduled time (configurable)
- [ ] Cancel notifications when treatment is completed
- [ ] Reschedule notifications if routine changes
- [ ] Handle timezone changes
- [ ] Implement recurring notification patterns

#### 3. Notification Types
**Tasks**:
- [ ] Treatment reminder notifications
  - "Time for your Gua Sha treatment!"
  - Include quick action buttons (Start Now, Snooze, Skip)
- [ ] Streak milestone notifications
  - "You're on a 7-day streak! Keep going!"
- [ ] Achievement notifications
  - "You've completed 30 treatments total!"
- [ ] Tip notifications
  - Daily treatment tips and best practices
- [ ] Missed treatment notifications
  - "You missed your scheduled Gua Sha yesterday"

#### 4. Notification Actions
**Tasks**:
- [ ] Implement "Start Now" action (deep link to treatment)
- [ ] Add "Snooze" action (10, 30, 60 minutes options)
- [ ] Add "Skip" action (mark as skipped, update schedule)
- [ ] Add "Mark as Done" action (if completed manually)
- [ ] Handle notification tap (navigate to appropriate screen)

#### 5. Notification Preferences
**Tasks**:
- [ ] Add settings page for notification customization
- [ ] Toggle notifications on/off per treatment type
- [ ] Set reminder lead time (5, 10, 15, 30 minutes)
- [ ] Choose notification sound
- [ ] Set quiet hours (no notifications during sleep)
- [ ] Configure notification vibration pattern

**Technical Implementation**:
```dart
class NotificationService {
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  });

  Future<void> scheduleRecurringNotification({
    required int id,
    required String title,
    required String body,
    required List<int> weekdays,
    required TimeOfDay time,
  });

  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotifications();
}
```

### Photo Gallery

#### 1. Gallery View Implementation
**Location**: `lib/features/progress/widgets/progress_content.dart:7-18`

**Tasks**:
- [ ] Create photo grid view widget
- [ ] Load photos from local cache and cloud
- [ ] Implement infinite scroll / pagination
- [ ] Show photo date and treatment type overlay
- [ ] Add selection mode for bulk operations
- [ ] Implement photo filtering:
  - By treatment type
  - By date range
  - By presence of notes
- [ ] Sort options (newest first, oldest first)
- [ ] Show loading skeletons while fetching

**UI Components**:
```dart
class PhotoGalleryView extends StatelessWidget {
  // GridView.builder with cached images
  // Filter chips for treatment types
  // Date range picker
  // Selection mode toggle
}

class PhotoGridTile extends StatelessWidget {
  // Thumbnail image
  // Date overlay
  // Treatment type badge
  // Selection checkbox
}
```

#### 2. Photo Comparison Feature
**Location**: `lib/features/progress/widgets/progress_content.dart:11-13`

**Tasks**:
- [ ] Create side-by-side comparison view
- [ ] Allow user to select two photos for comparison
- [ ] Show photos at same zoom level
- [ ] Add slider to transition between photos
- [ ] Display date difference between photos
- [ ] Show facial measurements comparison (if available)
- [ ] Add export comparison as single image
- [ ] Support before/after labels

**Existing File**: `lib/features/progress/pages/photo_comparison_page.dart`
**Tasks for Enhancement**:
- [ ] Load real photos from gallery instead of assets
- [ ] Add photo selection from gallery
- [ ] Save favorite comparisons
- [ ] Share comparison images
- [ ] Add measurement overlays

#### 3. Photo Details View
**Tasks**:
- [ ] Full-screen photo viewer with pinch-to-zoom
- [ ] Show treatment details (date, type, duration)
- [ ] Display notes if available
- [ ] Show facial metrics if available
- [ ] Add edit notes functionality
- [ ] Add delete photo option (with confirmation)
- [ ] Navigate between photos with swipe gestures
- [ ] Add share functionality

#### 4. Timeline View
**Tasks**:
- [ ] Create timeline visualization of progress
- [ ] Show photos chronologically with connecting line
- [ ] Display treatment frequency chart
- [ ] Add milestone markers (1 week, 1 month, 3 months)
- [ ] Show progress indicators (treatments completed)
- [ ] Add annotations for significant changes
- [ ] Export timeline as PDF report

#### 5. Photo Management
**Location**: `lib/features/treatment/widgets/post_treatment_form_content.dart:155-158`

**Tasks**:
- [ ] Generate and store thumbnails (200x200)
- [ ] Organize photos by date and treatment type
- [ ] Implement local caching strategy
- [ ] Add photo compression (reduce file size)
- [ ] Support photo upload from gallery for backfilling
- [ ] Implement photo deletion (local + cloud)
- [ ] Add photo backup/restore functionality
- [ ] Handle storage quota limits gracefully

#### 6. Analytics & Insights
**Tasks**:
- [ ] Calculate consistency score (treatments per week)
- [ ] Show treatment streak visualization
- [ ] Display treatment type distribution chart
- [ ] Show average session duration
- [ ] Identify most consistent days/times
- [ ] Generate progress reports
- [ ] Add exportable statistics

**Technical Implementation**:
```dart
class PhotoGalleryService {
  Future<List<ProgressPhoto>> getPhotosByDateRange(DateTime start, DateTime end);
  Future<List<ProgressPhoto>> getPhotosByTreatmentType(String type);
  Future<ProgressPhoto> getPhotoDetails(String photoId);
  Future<void> deletePhoto(String photoId);
  Future<String> generateComparison(String photo1Id, String photo2Id);
}

class ProgressPhoto {
  final String id;
  final String userId;
  final String photoUrl;
  final String thumbnailUrl;
  final DateTime date;
  final String treatmentType;
  final String? notes;
  final FacialMetrics? metrics;
}
```

---

## 📊 Implementation Priority

### High Priority (Do First)
1. **Milestone 3 - Backend Infrastructure** (Foundation for everything)
   - Authentication system
   - Database setup
   - Cloud storage
   - Data synchronization

2. **Milestone 2 - Treatment Workflows** (Core functionality)
   - Gua Sha step-by-step workflow
   - Electric Stimulator workflows
   - Treatment timers and progress tracking

### Medium Priority (Do Second)
3. **Milestone 4 - Scheduler & Notifications** (User engagement)
   - Routine scheduler
   - Local notifications
   - Reminder system

4. **Milestone 1 - Face Detection** (Enhanced experience)
   - Real-time face detection
   - Facial landmark extraction
   - Photo quality validation

### Lower Priority (Polish)
5. **Milestone 4 - Photo Gallery** (Nice to have)
   - Gallery view
   - Photo comparison
   - Timeline view
   - Analytics

---

## 🔧 Recommended Packages

### Authentication & Backend
- `firebase_auth: ^4.15.3` - Firebase authentication
- `cloud_firestore: ^4.13.6` - Cloud database
- `firebase_storage: ^11.5.6` - Cloud photo storage
- `flutter_secure_storage: ^9.0.0` - Secure token storage

### Local Storage
- `sqflite: ^2.3.0` - Local SQL database
- `hive: ^2.2.3` - Fast NoSQL local storage

### Notifications
- `flutter_local_notifications: ^16.3.0` - Local notifications
- `timezone: ^0.9.2` - Timezone support for scheduling

### Face Detection
- `google_ml_kit: ^0.16.0` - ML Kit for face detection
- `camera: ^0.10.5` - Camera access and control

### Image Processing
- `image: ^4.1.3` - Image manipulation and compression
- `flutter_image_compress: ^2.1.0` - Image compression

### UI/UX
- `cached_network_image: ^3.3.0` - Image caching
- `shimmer: ^3.0.0` - Loading skeletons
- `photo_view: ^0.14.0` - Pinch-to-zoom images
- `fl_chart: ^0.65.0` - Charts for analytics

---

## 📝 Notes

- All TODO comments in code are prefixed with milestone number
- File locations are provided for easy navigation
- Technical implementation examples included where applicable
- Priority order reflects dependencies between milestones
- Estimated total development time: 8-12 weeks for full implementation

---

**Last Updated**: 2025-10-30
**Version**: 1.0
**Maintainer**: Development Team
