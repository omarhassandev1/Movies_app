import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'package:movies_app/features/main_layer/home/bloc/home_bloc.dart';
import 'package:movies_app/features/main_layer/home/bloc/home_event.dart';
import 'package:movies_app/features/main_layer/home/bloc/home_state.dart';
import 'package:movies_app/features/main_layer/home/screens/category_movies.dart';
import 'package:movies_app/features/movie_details/presentation/movie_detail_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(RepositoryProvider.of<MovieRepository>(context))
        ..add(FetchHomeMovies()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.yellow));
          }

          if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  //  (Top Rated)
                  _buildSection(
                    context: context,
                    title: "Top Rated",
                    movies: state.topRated,
                    params: {'minimum_rating': 8, 'sort_by': 'rating', 'order_by': 'desc'},
                  ),

                  // Latest Movies
                  _buildSection(
                    context: context,
                    title: "Latest Movies",
                    movies: state.latest,
                    params: {'sort_by': 'date_added', 'order_by': 'desc'},
                  ),

                  // Most Downloaded
                  _buildSection(
                    context: context,
                    title: "Most Downloaded",
                    movies: state.mostDownloaded,
                    params: {'sort_by': 'download_count', 'order_by': 'desc'},
                  ),

                  //  Action
                  _buildSection(
                    context: context,
                    title: "Action",
                    movies: state.action,
                    params: {'genre': 'action', 'minimum_rating': 7, 'sort_by': 'download_count'},
                  ),

                  // Comedy
                  _buildSection(
                    context: context,
                    title: "Comedy",
                    movies: state.comedy,
                    params: {'genre': 'comedy', 'minimum_rating': 7, 'sort_by': 'rating'},
                  ),

                  // Romance
                  _buildSection(
                    context: context,
                    title: "Romance",
                    movies: state.romance,
                    params: {'genre': 'romance', 'minimum_rating': 7, 'sort_by': 'rating'},
                  ),

                  // Sci-Fi
                  _buildSection(
                    context: context,
                    title: "Sci-Fi",
                    movies: state.sciFi,
                    params: {'genre': 'sci-fi', 'minimum_rating': 7, 'sort_by': 'rating'},
                  ),

                  // Horror
                  _buildSection(
                    context: context,
                    title: "Horror",
                    movies: state.horror,
                    params: {'genre': 'horror', 'minimum_rating': 6, 'sort_by': 'download_count'},
                  ),

                  //  Drama
                  _buildSection(
                    context: context,
                    title: "Drama",
                    movies: state.drama,
                    params: {'genre': 'drama', 'minimum_rating': 7, 'sort_by': 'rating'},
                  ),

                  //  Animation
                  _buildSection(
                    context: context,
                    title: "Animation",
                    movies: state.animation,
                    params: {'genre': 'animation', 'minimum_rating': 7, 'sort_by': 'rating'},
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            );
          }

          return const Center(
            child: Text('Failed to load movies', style: TextStyle(color: Colors.red)),
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<Movie> movies,
    required Map<String, dynamic> params,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RepositoryProvider.value(
                        value: RepositoryProvider.of<MovieRepository>(context),
                        child: CategoryMoviesScreen(title: title, params: {...params, 'limit': 50}),
                      ),
                    ),
                  );
                },
                child: const Text('See More >', style: TextStyle(color: Colors.grey, fontSize: 14)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: movies.length,
            itemBuilder: (context, i) {
              final movie = movies[i];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => MovieDetailScreen(movieId: movie.id)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          movie.mediumCoverImage,
                          height: 200,
                          width: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 200,
                            width: 140,
                            color: Colors.grey[800],
                            child: const Icon(Icons.movie, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 140,
                        child: Text(
                          movie.title,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text('${movie.rating} stars', style: const TextStyle(color: Colors.yellow, fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}