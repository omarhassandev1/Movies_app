import 'package:dio/dio.dart';

class ProfileApiServices {
  final Dio dio;

  ProfileApiServices({required this.dio});

  Future<Response> getProfile({required String token}) async {
    return dio.get(
      'profile',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<Response> updateProfile({
    required Map<String, dynamic> data,
    required String token,
  }) async {
    return dio.patch(
      'profile',
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
