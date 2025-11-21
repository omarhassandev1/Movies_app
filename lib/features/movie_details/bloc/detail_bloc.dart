import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'package:movies_app/features/movie_details/bloc/detail_event.dart';
import 'package:movies_app/features/movie_details/bloc/detail_state.dart';
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final MovieRepository repo;

  DetailBloc(this.repo) : super(const DetailInitial()) {
    on<LoadDetail>(_onLoadDetail);
  }

  Future<void> _onLoadDetail(LoadDetail event, Emitter<DetailState> emit) async {
    emit(const DetailLoading());

    try {
      final movie = await repo.getMovieDetail(event.movieId);
      if (movie == null) {
        emit(const DetailError('Movie not found'));
        return;
      }
      final suggestions = await repo.getMovieSuggestions(event.movieId);
      emit(DetailLoaded(movie, suggestions));
    } catch (e) {
      print('DetailBloc Error: $e');
      emit(const DetailError('Failed to load movie details'));
    }
  }
}
