import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'search_event.dart';
import 'search_state.dart';
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository repo;
  SearchBloc(this.repo) : super(SearchInitial()) {
    on<SearchMovies>(_onSearch);
  }
  Future<void> _onSearch(SearchMovies event, Emitter<SearchState> emit) async {
    final query = event.query?.trim();
    final params = event.params;

    if (query == null && params == null) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final Map<String, dynamic> finalParams = {};
      if (query != null && query.isNotEmpty) {
        finalParams['query_term'] = query;
      }
      finalParams.addAll(params ?? {});
      finalParams['limit'] = 50;

      final movies = await repo.listMovies(params: finalParams);
      emit(SearchLoaded(movies));
    } catch (_) {
      emit(SearchError());
    }
  }
}

