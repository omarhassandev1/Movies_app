import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;
  String? userToken;

  AuthCubit(this.repo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await repo.login(email: email, password: password);
      final userToken = response['token'];
      final message = response['message'];
      emit(AuthSuccess(data: userToken, message: message));
    } on DioException catch (e) {
      final data = e.response?.data;
      var message = data?['message'];

      if (message is List) {
        message = message.join(',\n');
      }
      emit(AuthFailure(message ?? 'Something went wrong'));
    }
    catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String cellphone,
    required int avatarNo,
  }) async {
    emit(AuthLoading());
    try {
      final message = await repo.register(
        name: name,
        email: email,
        password: password,
        cellphone: cellphone,
        avatarNo: avatarNo,
        confirmPassword: confirmPassword,
      );
      emit(AuthSuccess(message: message));
    } on DioException catch (e) {
      final data = e.response?.data;
      var message = data?['message'];

      if (message is List) {
        message = message.join(', ');
      }
      emit(AuthFailure(message ?? 'Something went wrong'));
    }
    catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
