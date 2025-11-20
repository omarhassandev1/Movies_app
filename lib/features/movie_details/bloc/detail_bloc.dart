import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'detail_event.dart';
import 'detail_state.dart';
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final MovieRepository repo;

  DetailBloc(this.repo) : super(DetailInitial()) {
    on<LoadDetail>(_onLoad);
  }

  Future<void> _onLoad(LoadDetail event, Emitter<DetailState> emit) async {
    emit( DetailLoading());
    try {
      final movie = await repo.getMovieDetail(event.movieId);
      final suggestions = await repo.getMovieSuggestions(event.movieId);
      emit(DetailLoaded(movie, suggestions));
    } catch (_) {
      emit( DetailError());
    }
  }
}