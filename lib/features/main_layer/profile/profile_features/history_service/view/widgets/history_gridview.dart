import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../favorites/view/rating_widget.dart';
import '../../../history_service/cubit/history_cubit.dart';
import '../../cubit/history_state.dart';

class HistoryGridview extends StatelessWidget {
  const HistoryGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.mainColor),
          );
        }

        if (state is HistoryError) {
          return Center(
            child: Text("Error: ${state.message}"),
          );
        }

        if (state is HistoryLoaded) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return Center(child: Assets.common.popcorn.image());
          }

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 5,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: movies[index]);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: movie.mediumCoverImage,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [RatingWidget(rating: movie.rating)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
