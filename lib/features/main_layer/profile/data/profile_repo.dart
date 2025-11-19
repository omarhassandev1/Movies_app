import 'package:movies_app/data/models/user_model.dart';
import 'package:movies_app/features/main_layer/profile/data/profile_api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  final ProfileApiServices apiServices;

  ProfileRepo({required this.apiServices});

  Future<UserModel> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    if (authToken == null) {
      throw Exception('Authentication token not found. User needs to sign in.');
    }
    final response = await apiServices.getProfile(token: authToken);
    if (response.statusCode == 200 && response.data != null) {
      final message = response.data['message'];
      if (message == 'Profile fetched successfully') {
        final data = response.data['data'];
        final UserModel user = UserModel.fromJson(data);
        return user;
      } else {
        throw Exception('Could not fetch the user\'s data');
      }
    } else {
      throw Exception('Profile is not found');
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    if (authToken == null) {
      throw Exception('Authentication token not found. User needs to sign in.');
    }

    final response = await apiServices.updateProfile(
      data: data,
      token: authToken,
    );
    if (response.statusCode == 200 && response.data != null) {
      final message = response.data['message'];
      if (message == 'Profile updated successfully') {
        return true;
      } else {
        throw Exception('Could not update the user\'s data');
      }
    } else {
      throw Exception('something went wrong');
    }
  }

  Future<bool> deleteProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    if (authToken == null) {
      throw Exception('Authentication token not found. User needs to sign in.');
    }
    final response = await apiServices.deleteProfile(token: authToken);
    if (response.statusCode == 200 && response.data != null) {
      final message = response.data['message'];
      if (message == 'Profile deleted successfully') {
        prefs.setBool('isLoggedIn', false);
        return true;
      } else {
        throw Exception('Could not delete the account');
      }
    } else {
      throw Exception('something went wrong');
    }
  }
}
