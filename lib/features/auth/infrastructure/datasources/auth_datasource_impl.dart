import 'package:clinic_app/features/shared/shared.dart';
import 'package:dio/dio.dart';

import 'package:clinic_app/config/config.dart';
import 'package:clinic_app/features/auth/domain/domain.dart';
import 'package:clinic_app/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: "${Environment.apiUrl}/${Environment.version}"),
  );

  @override
  Future<AuthUser> login(String email, String password) async {
    try {
      final response = await dio.post("/auth/login", data: {
        "email": email,
        "password": password,
      });

      final authResponse = ApiResponse<AuthUser>.fromJson(
        response.data,
        (json) => AuthUserMapper.userJsonToEntity(json),
      );

      return authResponse.result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthUserError(
            e.response?.data["message"] ?? "Correo o contraseña incorrectos");
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw AuthUserError("Timeout");
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<AuthUser> checkAuthStatus(String token) async {
    try {
      final response = await dio.get(
        "/auth/check-auth-status",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      final authResponse = ApiResponse<AuthUser>.fromJson(
        response.data,
        (json) => AuthUserMapper.userJsonToEntity(json),
      );

      return authResponse.result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthUserError("Token incorrecto");
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw AuthUserError("Timeout");
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
