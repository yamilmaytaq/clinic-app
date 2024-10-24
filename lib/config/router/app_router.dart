import 'package:clinic_app/features/auth/auth.dart';
import 'package:clinic_app/features/clinic/clinic.dart';
import 'package:clinic_app/config/router/app_router_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      //* Splash Routes
      GoRoute(
        path: "/splash",
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      //* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      //* Clinic Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const MainMenu(),
      ),
      GoRoute(
        path: '/predictive-diagnosis',
        builder: (context, state) => const PredictiveDiagnosisScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == "/splash" && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == "/login") return null;
        return "/login";
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == "/login" || isGoingTo == "/splash") return "/";
      }

      //? Se puede hacer esto: if (user.isAdmin)

      return null;
    },
  );
});
