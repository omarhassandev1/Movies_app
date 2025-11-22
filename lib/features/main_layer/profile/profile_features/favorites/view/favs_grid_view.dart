import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import '../../../../../../gen/assets.gen.dart';
import '../cubits/fav_cubit.dart';
import '../cubits/fav_state.dart';
import 'movie_card.dart';

class FavGridView extends StatefulWidget {
  const FavGridView({super.key});

  @override
  State<FavGridView> createState() => _FavGridViewState();
}

class _FavGridViewState extends State<FavGridView> {
  @override
  void initState() {
    super.initState();
    context.read<FavCubit>().getAllFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FavCubit, FavState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.mainColor),
            );
          } else if (state is FavoriteGetSuccess) {
            return state.favMovies.isEmpty
                ? Center(child: Assets.common.popcorn.image())
                : GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 5,
                  ),
                  itemCount: state.favMovies.length,
                  itemBuilder:
                      (context, index) =>
                          state.favMovies.isEmpty
                              ? Center(child: Assets.common.popcorn.image())
                              : MovieCard(favMovie: state.favMovies[index]),
                );
          } else if (state is FavoriteError) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.redColor,
                      size: 30,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Assets.common.popcorn.image());
          }
        },
      ),
    );
  }
}
