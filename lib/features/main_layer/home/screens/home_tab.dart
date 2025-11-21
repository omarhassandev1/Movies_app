import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'package:movies_app/features/main_layer/home/bloc/home_bloc.dart';
import 'package:movies_app/features/main_layer/home/bloc/home_event.dart';
import 'package:movies_app/features/main_layer/home/bloc/home_state.dart';
import 'package:movies_app/features/main_layer/home/screens/category_movies.dart';
import 'package:movies_app/features/movie_details/presentation/movie_detail_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.55);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      HomeBloc(RepositoryProvider.of<MovieRepository>(context))
        ..add(FetchHomeMovies()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.yellow));
          }

          if (state is HomeLoaded) {
            final featured = state.topRated.take(20).toList();

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.67,
                    child: Stack(
                      children: [

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 900),
                          child: Container(
                            key: ValueKey(featured[_currentIndex].id),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  featured[_currentIndex].mediumCoverImage.replaceFirst('medium', 'large'),
                                ),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.dstATop,
                                ),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.3),
                                    Colors.black.withOpacity(0.85),
                                  ],
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/common/Available Now.png',
                            height: 110,
                            fit: BoxFit.contain,
                          ),
                        ),
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (i) =>
                              setState(() => _currentIndex = i),
                          itemCount: featured.length,
                          itemBuilder: (context, index) {
                            final movie = featured[index];
                            final isCenter = index == _currentIndex;
                            final scale = isCenter ? 1.0 : 0.8;

                            return GestureDetector(
                              onTap: () =>
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) =>
                                        MovieDetailScreen(movieId: movie.id)),
                                  ),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeOutQuint,
                                transform: Matrix4.identity()
                                  ..scale(scale),
                                child: Opacity(
                                  opacity: isCenter ? 1.0 : 0.55,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: isCenter ? 160 : 240,
                                      bottom: isCenter ? 100 : 50,
                                    ),
                                    child: Material(
                                      elevation: isCenter ? 40 : 10,
                                      borderRadius: BorderRadius.circular(
                                          isCenter ? 16 : 16),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            isCenter ? 16 : 16),
                                        child: Stack(
                                          children: [
                                            Hero(
                                              tag: 'hero-${movie.id}',
                                              child: CachedNetworkImage(
                                                imageUrl: movie.mediumCoverImage
                                                    .replaceFirst(
                                                    'medium', 'large'),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                            ),
                                            if (isCenter)
                                              Positioned(
                                                top: 20,
                                                left: 20,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 14,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                    borderRadius: BorderRadius
                                                        .circular(16),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize
                                                        .min,
                                                    children: [
                                                      Text(
                                                        '${movie.rating}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight
                                                                .bold),
                                                      ),
                                                      const SizedBox(width: 8),

                                                      const Icon(Icons.star,
                                                          color: Colors.yellow,
                                                          size: 24),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 30,
                          left: 16,
                          right: 16,
                          child: Image.asset(
                            'assets/common/Watch Now.png',
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSection(
                      context, "Action", state.action, {'genre': 'action'}),
                  _buildSection(
                      context, "Comedy", state.comedy, {'genre': 'comedy'}),
                  _buildSection(
                      context, "Romance", state.romance, {'genre': 'romance'}),
                  _buildSection(
                      context, "Sci-Fi", state.sciFi, {'genre': 'sci-fi'}),
                  _buildSection(
                      context, "Horror", state.horror, {'genre': 'horror'}),
                  _buildSection(
                      context, "Drama", state.drama, {'genre': 'drama'}),
                  _buildSection(context, "Animation", state.animation,
                      {'genre': 'animation'}),

                  const SizedBox(height: 120),
                ],
              ),
            );
          }

          return const Center(child: Text(
              'Failed to load', style: TextStyle(color: Colors.red)));
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Movie> movies,
      Map<String, dynamic> params) {
    if (movies.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            RepositoryProvider.value(
                              value: RepositoryProvider.of<MovieRepository>(
                                  context),
                              child: CategoryMoviesScreen(title: title,
                                  params: {...params, 'limit': 50}),
                            ),
                      ),
                    ),
                child: const Text('See More >',
                    style: TextStyle(color: Colors.yellow, fontSize: 16)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: movies.length,
            itemBuilder: (context, i) {
              final m = movies[i];

              return GestureDetector(
                onTap: () =>
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MovieDetailScreen(movieId: m.id)),
                    ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 150,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: m.mediumCoverImage,
                          height: 230,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${m.rating}',
                                style: const TextStyle(color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                  Icons.star, color: Colors.yellow, size: 24),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.transparent
                              ],
                            ),
                          ),
                          child: Text(
                            m.title,
                            style: const TextStyle(color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
