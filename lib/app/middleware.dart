import 'app_prefs.dart';
import 'injections.dart';
import '../presentation/routing/routes.dart';

AppPreferences appPreferences = getit.get();
String initialScreenMiddleware() {
  if (appPreferences.isLoggedIn()) {
    return Routes.homeScreen;
  } else {
    return Routes.onboarding;
  }
}
