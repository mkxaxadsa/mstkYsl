import 'package:go_router/go_router.dart';

import '../../features/fortune/pages/fortune_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/home/pages/rules_page.dart';
import '../../features/home/pages/settings_page.dart';
import '../../features/slot/pages/slot_page.dart';
import '../../features/onboard/pages/onboard_page.dart';
import '../../features/onboard/pages/onboard_page2.dart';
import '../../features/onboard/pages/onboard_page3.dart';
import '../../features/splash/splash_page.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/rules',
      builder: (context, state) => const RulesPage(),
    ),
    GoRoute(
      path: '/fortune',
      builder: (context, state) => const FortunePage(),
    ),
    GoRoute(
      path: '/slot',
      builder: (context, state) {
        var map = state.extra as Pages;
        return SlotPage(page: map);
      },
    ), GoRoute(
      path: '/onboard1',
      builder: (context, state) {
        var map = state.extra as Pages;
        return OnboardPage(page: map);
      },
    ), GoRoute(
      path: '/onboard2',
      builder: (context, state) {
        var map = state.extra as Pages;
        return OnboardPage2(page: map);
      },
    ),
    GoRoute(
      path: '/onboard3',
      builder: (context, state) {
        var map = state.extra as Pages;
        return OnboardPage3(page: map);
      },
    ),
  ],
);
