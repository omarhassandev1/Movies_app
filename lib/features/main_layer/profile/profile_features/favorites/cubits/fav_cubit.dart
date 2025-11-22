import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/fav_repo.dart';
import 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  final FavRepo favRepo;
  FavCubit({required this.favRepo}) : super(FavoriteInitial());

  Future<void> getAllFavorites() async {
    emit(FavoriteLoading());
    try {
      final favMovies = await favRepo.getFavMovies();
      emit(FavoriteGetSuccess(favMovies: favMovies));
    } catch (e) {
      emit(FavoriteError(errorMessage: e.toString()));
    }
  }
}
