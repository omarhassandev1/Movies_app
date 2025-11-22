import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../data/models/repository/movie_repository.dart';
import '../services/history_service.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryLoading()) {
    loadHistory();
  }

  final MovieRepository _repo = MovieRepository();

  Future<void> loadHistory() async {
    emit(HistoryLoading());
    try {
      final ids = await HistoryService.getHistory();
      final movies = await Future.wait(ids.map((id) => _repo.getMovieDetail(id)).toList());
      emit(HistoryLoaded(movies));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> addToHistory(int id) async {
    await HistoryService.addToHistory(id);
    loadHistory();
  }

  Future<void> clearHistory() async {
    await HistoryService.clearHistory();
    emit(HistoryLoaded([]));
  }
}
