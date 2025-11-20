import 'package:dio/dio.dart';
import 'package:movies_app/common/consts/api_consts.dart';

class ProfileApiServices {
  final Dio dio;

  ProfileApiServices({required this.dio});

  Future<Response> getProfile({required String token}) async {
    return dio.get(
      RouteApiConsts.getProfileEndPoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<Response> updateProfile({
    required Map<String, dynamic> data,
    required String token,
  }) async {
    return dio.patch(
      RouteApiConsts.updateProfileEndPoint,
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<Response> deleteProfile({required String token}) async {
    return dio.delete(
      RouteApiConsts.deleteProfileEndPoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
