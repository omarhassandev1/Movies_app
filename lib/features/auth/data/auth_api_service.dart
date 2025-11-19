import 'package:dio/dio.dart';

import 'auth_service.dart';

class AuthApiService extends AuthService {
  AuthApiService(super.dio);

  @override
  Future<Response> postLogin(Map<String, dynamic> data) async {
    return await dio.post('auth/login', data: data);
  }

  @override
  Future<Response> postRegister(Map<String, dynamic> data) async {
    return await dio.post('auth/register', data: data);
  }

  @override
  Future<Response> postResetPassword(Map<String, dynamic> data) async {
    return await dio.post('auth/reset-password', data: data);
  }

}
