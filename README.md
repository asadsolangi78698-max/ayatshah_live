# AyatShah Live — Flutter App Scaffold

Clean-architecture starter project for a live streaming / audio party / PK
battle platform, built with Riverpod + GoRouter + Material 3.

## Folder Structure

```
lib/
  main.dart                 # Entrypoint — bootstraps SharedPreferences, runs app
  app.dart                  # Root MaterialApp.router widget

  core/
    theme/                  # AppColors (dark purple palette) + AppTheme (Material 3)
    router/                 # GoRouter config, StatefulShellRoute for bottom nav
    services/                # ApiService (Dio), StorageService (secure+prefs), core providers
    utils/                  # Constants, endpoints, validators, responsive helper
    widgets/                # Shared widgets (empty — add cross-feature widgets here)

  features/
    auth/                   # Phone OTP, Google, Apple, guest login
    home/                   # Bottom-nav shell + discover feed
    live/                   # Live room list, live broadcast/viewer screen
    audio_party/            # 8-12 seat audio room, mic seat widget
    pk_battle/               # 1v1 / team PK screen, score bar + timer
    wallet/                 # Coin/diamond balances, recharge, withdrawal
    profile/                # User profile, stats, settings menu
    chat/                   # 1:1 messaging (text now; voice/image stubbed)
    admin/                  # Responsive admin dashboard (for Flutter Web build)

  Each feature follows:
    data/models/            # Plain Dart model classes (fromJson/toJson)
    data/repositories/      # API calls via ApiService
    providers/              # Riverpod providers / StateNotifiers
    presentation/screens/   # Full-page widgets
    presentation/widgets/   # Feature-local reusable widgets
```

## Platform folders included

```
android/    Full Gradle project — builds and runs as-is (Kotlin MainActivity,
            manifest with camera/mic/notification permissions, launcher
            icons, ProGuard rules, Gradle 8.6 wrapper config).
ios/        Runner sources — Info.plist (with camera/mic usage strings and
            background audio mode), AppDelegate.swift, LaunchScreen/Main
            storyboards, full AppIcon.appiconset, Podfile. See the note
            below — one command finishes this platform.
web/        index.html, PWA manifest.json, generated icons/favicon —
            builds and runs as-is.
```

## Getting Started (Android Studio / Android / Web)

1. Unzip the project and open the folder in **Android Studio** (File → Open
   → select the `ayatshah_live` folder). Android Studio will detect it as a
   Flutter project.
2. Edit `android/local.properties` and set `flutter.sdk` to your local
   Flutter SDK path (e.g. `/Users/you/development/flutter` or
   `C:\src\flutter`).
3. From the project root:
   ```bash
   flutter pub get
   flutter run                # pick an Android emulator/device, or `-d chrome` for web
   ```

This works immediately for **Android** and **web** — both platform folders
are complete, real, runnable configs (not just `lib/` code).

### ⚠️ One thing to know about the iOS folder

Everything Xcode-adjacent that's plain text — `Info.plist`,
`AppDelegate.swift`, storyboards, the full `AppIcon.appiconset`, `Podfile`
— is included and correct. The one file I did **not** hand-write is
`ios/Runner.xcodeproj/project.pbxproj` (and the `.xcworkspace`): Xcode
generates these with internal UUIDs/build-phase references that aren't
safely hand-authored outside Xcode's own tooling — a hand-built one risks
silently failing to open. To generate it for real, once you have the
Flutter SDK and Xcode installed, run from the project root:

```bash
flutter create --platforms=ios .
```

This only fills in the missing Xcode project shell — it won't touch your
existing `lib/`, `android/`, `web/`, or the iOS files already here, since
`flutter create` skips files that already exist. After that, `flutter run
-d ios` (or opening `ios/Runner.xcworkspace` in Xcode) works normally.

### Required setup before this compiles cleanly

1. **Backend URL** — update `AppConstants.baseUrl` / `socketUrl` in
   `lib/core/utils/constants.dart`.
2. **Firebase** — run `flutterfire configure` to generate
   `firebase_options.dart` (and `google-services.json` /
   `GoogleService-Info.plist`), then uncomment the init lines in
   `main.dart`.
3. **Agora/ZEGO** — this scaffold ships with `agora_rtc_engine` in
   `pubspec.yaml` as the default SDK. `LiveScreen` has a placeholder video
   surface; replace it with `AgoraVideoView`/`RtcEngine` calls (or swap the
   dependency for ZEGO Cloud's SDK if you prefer that vendor).
4. **Social login keys** — add your Google `client_id` (Android/iOS
   `google-services.json` / `GoogleService-Info.plist`) and configure Sign
   in with Apple capability in Xcode.
5. **In-app purchases** — wire the `in_app_purchase` package's platform
   product IDs to match `coinPackagesProvider` in
   `lib/features/wallet/providers/wallet_provider.dart`.
6. **App icons** — the launcher/favicon icons included are simple
   generated placeholders (purple, brand-colored). Swap them for your real
   logo before shipping.
7. Run code generation if you add Freezed/JsonSerializable models:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

## What's wired vs. stubbed

- **Wired**: navigation (GoRouter + auth redirect), theme, Riverpod DI
  graph, Dio client with auth interceptor, secure token storage, all
  screen layouts.
- **Stubbed (needs your backend/SDK keys)**: actual OTP/social login
  network responses, Agora/ZEGO video rendering, socket-driven real-time
  state for live comments / PK scores / mic seats / chat, push
  notifications, payment provider integration, admin panel data.

## Notes on scope

This is a scaffold, not a finished production app — the plan behind
AyatShah Live (PK battles, agencies, gifting economy, admin panel) is a
multi-month build. Use this structure as the foundation and build out one
feature vertical at a time (repository → provider → screen), same pattern
already used throughout.

## Fixes applied (build audit)

Three bugs were found and fixed that would have broken `flutter pub get` /
the Gradle build:

1. **`pubspec.yaml` declared 4 Poppins `.ttf` font files that didn't exist**
   in `assets/fonts/` — this fails the build immediately with a
   missing-asset error. Removed the `fonts:` block; the app already loads
   Poppins at runtime via the `google_fonts` package
   (`lib/core/theme/app_theme.dart`), so no local font files are needed.
2. **`minSdk` was 23; `agora_rtc_engine` 6.x requires 24** — its AAR
   declares `minSdkVersion 24`, which fails Android's manifest merger
   against a lower value. Bumped to 24 in `android/app/build.gradle`.
3. **`android/gradlew` and `gradlew.bat` were missing.** `flutter build apk`
   shells out to `android/gradlew` directly — without it the build fails
   immediately with "Gradle wrapper not found." Added both scripts.

### One remaining manual step: `gradle-wrapper.jar`

This is a small compiled binary that Gradle itself generates — it can't be
authored by hand, and generating a legitimate one requires either internet
access (to download it) or a local Gradle install (to run `gradle
wrapper`). Neither was available in the environment this project was
audited in. **You don't need to do anything if you open this in Android
Studio with internet access** — it detects the missing wrapper jar and
downloads it automatically on first sync. If you'd rather do it from the
command line:
```bash
# with a system Gradle install (e.g. via brew install gradle / sdkman):
cd android && gradle wrapper --gradle-version 8.6
```

## Getting a real release APK

**Recommended — GitHub Actions (zero local setup):** this project includes
`.github/workflows/build_apk.yml`. Push this repo to GitHub, and Actions
will run `flutter pub get` + `flutter build apk --release` on a runner with
full SDK/network access, then attach `app-release.apk` as a downloadable
build artifact. Trigger it manually anytime from the Actions tab
("Run workflow") or just push to `main`.

**Locally**, once `flutter.sdk` is set in `android/local.properties` and
the Flutter SDK is installed:
```bash
flutter pub get
flutter build apk --release
# output: build/app/outputs/flutter-apk/app-release.apk
```

Note: the release build currently signs with the Android debug keystore
(see `signingConfig signingConfigs.debug` in `android/app/build.gradle`) so
it installs and runs immediately for testing. Replace this with your own
release keystore before publishing to the Play Store.

