import 'package:clinic_app/features/auth/domain/domain.dart';

class AuthUserMapper {
  static AuthUser userJsonToEntity(Map<String, dynamic> json) {
    return AuthUser(
      email: json['email'],
      token: json['token'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
