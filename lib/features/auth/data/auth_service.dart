import 'package:dio/dio.dart';

abstract class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<Response> postLogin(Map<String, dynamic> data);

  Future<Response> postRegister(Map<String, dynamic> data) ;

  Future<Response> postResetPassword(Map<String, dynamic> data) ;

}
