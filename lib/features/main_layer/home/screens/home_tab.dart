import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'package:movies_app/features/main_layer/home/bloc/home_state.dart';
import 'package:movies_app/features/main_layer/home/screens/category_movies.dart';
import 'package:movies_app/features/movie_details/presentation/movie_detail_screen.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
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
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Available Now',
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildHorizontalList(
                    context: context,
                    movies: state.featured,
                    sectionTitle: 'Top Rated',
                    sectionParams: {
                      'minimum_rating': 7,
                      'sort_by': 'rating',
                      'order_by': 'desc',
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Watch Now',
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildHorizontalList(
                    context: context,
                    movies: state.action,
                    sectionTitle: 'Action',
                    sectionParams: {
                      'genre': 'action',
                      'minimum_rating': 7,
                      'sort_by': 'download_count',
                      'order_by': 'desc',
                    },
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('Error loading movies', style: TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
  Widget _buildHorizontalList({
    required BuildContext context,
    required List<Movie> movies,
    required String sectionTitle,
    required Map<String, dynamic> sectionParams,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RepositoryProvider.value(
                        value: RepositoryProvider.of<MovieRepository>(context),
                        child: CategoryMoviesScreen(
                          title: sectionTitle,
                          params: sectionParams,
                        ),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'See More >',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
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
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MovieDetailScreen(movieId: movie.id),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      Text(
                        '${movie.rating} stars',
                        style: const TextStyle(color: Colors.yellow, fontSize: 12),
                      ),
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