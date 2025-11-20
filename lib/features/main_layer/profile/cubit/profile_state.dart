import 'package:movies_app/data/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileDeleteSuccess extends ProfileState {}

class ProfileGetSuccess extends ProfileState {
  final UserModel user;

  ProfileGetSuccess({required this.user});
}

class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError({required this.errorMessage});
}
