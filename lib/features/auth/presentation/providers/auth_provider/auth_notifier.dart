import 'package:clinic_app/features/shared/infrastructure/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clinic_app/features/auth/domain/domain.dart';
import 'package:clinic_app/features/auth/infrastructure/infrastructure.dart';
import 'package:clinic_app/features/auth/auth.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on AuthUserError catch (e) {
      logout(e.message);
    } catch (e) {
      logout("Error no controlado");
    }
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getKey<String>('token');

    if (token == null) return logout(null);

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout(null);
    }
  }

  Future<void> _setLoggedUser(AuthUser user) async {
    await keyValueStorageService.setKey<String>('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: "",
    );
  }

  Future<void> logout(String? errorMessage) async {
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }
}
