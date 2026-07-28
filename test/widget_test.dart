import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ayatshah_live/app.dart';
import 'package:ayatshah_live/core/services/core_providers.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const AyatShahLiveApp(),
      ),
    );

    // Initial route is /login, so the app should render immediately
    // without throwing during the first frame.
    await tester.pump();
    expect(find.text('AyatShah Live'), findsWidgets);
  });
}
