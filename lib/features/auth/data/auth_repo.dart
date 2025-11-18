import 'package:movies_app/features/auth/data/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final AuthService authService;

  AuthRepo(this.authService);

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await authService.postLogin({
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final token = data['data'];
        final message = data['message'];

        if (token != null && message == 'Success Login') {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          return {'token': token, 'message': message};
        } else {
          throw Exception('Token missing in response: $data');
        }
      } else {
        throw Exception('Invalid response format: $data');
      }
    } else {
      throw Exception(response.data?['message'] ?? 'Login failed');
    }
  }

  Future<String> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String cellphone,
    required int avatarNo,
  }) async {
    final response = await authService.postRegister({
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phone": cellphone,
      "avaterId": avatarNo,
    });

    if (response.statusCode == 201 && response.data != null) {
      final data = response.data;
      final userData = data['data'];

      if (data is Map<String, dynamic> && data['message'] == 'User created successfully') {
        if (userData == null) throw Exception('Missing user data in response');
        return data['message'];
      } else {
        throw Exception('Invalid response format: ${response.data}');
      }
    } else {
      throw Exception(response.data?['message'] ?? 'Registration failed');
    }
  }
}
