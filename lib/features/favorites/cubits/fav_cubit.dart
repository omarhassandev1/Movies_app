import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/favorites/cubits/fav_state.dart';
import 'package:movies_app/features/favorites/data/fav_repo.dart';

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
