import 'package:clinic_app/features/auth/domain/domain.dart';
import 'package:clinic_app/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl({AuthDatasource? authDatasource})
      : authDatasource = authDatasource ?? AuthDatasourceImpl();

  @override
  Future<AuthUser> login(String email, String password) {
    return authDatasource.login(email, password);
  }

  @override
  Future<AuthUser> checkAuthStatus(String token) {
    return authDatasource.checkAuthStatus(token);
  }
}
