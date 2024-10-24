import 'package:clinic_app/features/shared/infrastructure/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clinic_app/features/auth/auth.dart';
import 'package:clinic_app/features/auth/infrastructure/infrastructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});
