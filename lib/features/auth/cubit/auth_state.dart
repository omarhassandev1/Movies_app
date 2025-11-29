abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthPassUpdated extends AuthState {}

class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure(this.errorMessage);
}

class LoginSuccess extends AuthState {
  final String message;
  final dynamic data;
  LoginSuccess({required this.message, this.data});
}

class RegisterSuccess extends AuthState {
  final String message;
  final dynamic data;
  RegisterSuccess({required this.message, this.data});
}
class LogoutSuccess extends AuthState {}

