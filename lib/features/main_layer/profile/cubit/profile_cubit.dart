import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main_layer/profile/cubit/profile_state.dart';
import 'package:movies_app/features/main_layer/profile/data/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> getProfileData() async {
    emit(ProfileLoading());
    try {
      final userModel = await profileRepo.getProfile();

      emit(ProfileGetSuccess(user: userModel));
    } on DioException catch (e) {
      final data = e.response?.data;
      var message = data?['message'];

      if (message is List) {
        message = message.join(',\n');
      }
      emit(ProfileError(errorMessage: message ?? 'Something went wrong'));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    emit(ProfileLoading());
    try {
      await profileRepo.updateProfile(data);
      emit(ProfileUpdateSuccess());
    } on DioException catch (e) {
      final data = e.response?.data;
      var message = data?['message'];

      if (message is List) {
        message = message.join(',\n');
      }
      emit(ProfileError(errorMessage: message ?? 'Something went wrong'));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  Future<void> deleteProfile() async {
    emit(ProfileLoading());
    try {
      await profileRepo.deleteProfile();
      emit(ProfileDeleteSuccess());
    } on DioException catch (e) {
      final data = e.response?.data;
      var message = data?['message'];

      if (message is List) {
        message = message.join(',\n');
      }
      emit(ProfileError(errorMessage: message ?? 'Something went wrong'));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }
}
