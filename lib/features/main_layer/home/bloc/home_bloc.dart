import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'package:movies_app/features/main_layer/home/bloc/home_state.dart';
import 'home_event.dart';
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository repository;
  HomeBloc(this.repository) : super( HomeInitial()) {
    on<FetchHomeMovies>(_onFetchHomeMovies);
  }
  Future<void> _onFetchHomeMovies(
      FetchHomeMovies event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());
    try {
      final featured = await repository.listMovies(params: {
        'minimum_rating': 7,
        'sort_by': 'rating',
        'order_by': 'desc',
        'limit': 10,
      });
      final action = await repository.listMovies(params: {
        'genre': 'action',
        'minimum_rating': 7,
        'sort_by': 'download_count',
        'order_by': 'desc',
        'limit': 10,
      });
      emit(HomeLoaded(featured, action));
    } catch (_) {
      emit(HomeError());
    }
  }
}