import 'package:clinic_app/features/auth/domain/domain.dart';

abstract class AuthDatasource {
  Future<AuthUser> login(String email, String password);
  Future<AuthUser> checkAuthStatus(String token);
}
