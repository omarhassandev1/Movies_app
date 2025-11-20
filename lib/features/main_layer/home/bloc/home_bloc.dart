import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository repository;

  HomeBloc(this.repository) : super(const HomeInitial()) {
    on<FetchHomeMovies>(_onFetchHomeMovies);
  }

  Future<void> _onFetchHomeMovies(
      FetchHomeMovies event,
      Emitter<HomeState> emit,
      ) async {
    emit(const HomeLoading());
    try {
      final results = await Future.wait([
        repository.listMovies(params: {'minimum_rating': 8, 'sort_by': 'rating', 'order_by': 'desc', 'limit': 10}),
        repository.listMovies(params: {'sort_by': 'date_added', 'order_by': 'desc', 'limit': 10}),
        repository.listMovies(params: {'sort_by': 'download_count', 'order_by': 'desc', 'limit': 10}),
        repository.listMovies(params: {'genre': 'action', 'minimum_rating': 7, 'sort_by': 'download_count', 'limit': 10}),
        repository.listMovies(params: {'genre': 'comedy', 'minimum_rating': 7, 'sort_by': 'rating', 'limit': 10}),
        repository.listMovies(params: {'genre': 'romance', 'minimum_rating': 7, 'sort_by': 'rating', 'limit': 10}),
        repository.listMovies(params: {'genre': 'sci-fi', 'minimum_rating': 7, 'sort_by': 'rating', 'limit': 10}),
        repository.listMovies(params: {'genre': 'horror', 'minimum_rating': 6, 'sort_by': 'download_count', 'limit': 10}),
        repository.listMovies(params: {'genre': 'drama', 'minimum_rating': 7, 'sort_by': 'rating', 'limit': 10}),
        repository.listMovies(params: {'genre': 'animation', 'minimum_rating': 7, 'sort_by': 'rating', 'limit': 10}),
      ]);

      emit(HomeLoaded(
        topRated: results[0],
        latest: results[1],
        mostDownloaded: results[2],
        action: results[3],
        comedy: results[4],
        romance: results[5],
        sciFi: results[6],
        horror: results[7],
        drama: results[8],
        animation: results[9],
      ));
    } catch (e) {
      emit(const HomeError());
    }
  }
}
