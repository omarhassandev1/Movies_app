import 'package:dio/dio.dart';
import 'package:movies_app/common/consts/api_consts.dart';

import 'auth_service.dart';

class AuthApiService extends AuthService {
  AuthApiService(super.dio);

  @override
  Future<Response> postLogin(Map<String, dynamic> data) async {
    return await dio.post(RouteApiConsts.loginEndPoint, data: data);
  }

  @override
  Future<Response> postRegister(Map<String, dynamic> data) async {
    return await dio.post(RouteApiConsts.registerEndPoint, data: data);
  }

  @override
  Future<Response> patchResetPassword(Map<String, dynamic> data, String token) async {
    return dio.patch(
      RouteApiConsts.resetPasswordEndPoint,
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }



}
