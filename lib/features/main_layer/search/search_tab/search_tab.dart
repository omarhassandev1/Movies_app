import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'package:movies_app/features/movie_details/presentation/movie_detail_screen.dart';
import '../../profile/profile_features/history_service/cubit/history_cubit.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class SearchTab extends StatefulWidget {
  final Map<String, dynamic>? initialParams;
  const SearchTab({super.key, this.initialParams});
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _controller = TextEditingController();
  late final SearchBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = SearchBloc(RepositoryProvider.of<MovieRepository>(context));
    if (widget.initialParams != null) {
      _bloc.add(SearchMovies.withParams(widget.initialParams!));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Builder(
        builder:
            (innerContext) => SafeArea(
              child: Column(
                children: [
                  if (widget.initialParams == null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: const Color(0xFF282A28),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              "assets/main_layer/search.svg",
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        onChanged: (v) => _bloc.add(SearchMovies(v.trim())),
                      ),
                    ),

                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is SearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.yellow,
                            ),
                          );
                        }
                        if (state is SearchLoaded && state.movies.isNotEmpty) {
                          return ListView.builder(
                            itemCount: state.movies.length,
                            itemBuilder: (_, i) {
                              final m = state.movies[i];
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    m.mediumCoverImage,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  m.title,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${m.year} • ${m.rating} stars',
                                  style: const TextStyle(color: Colors.yellow),
                                ),
                                onTap:
                                    () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          context
                                              .read<HistoryCubit>()
                                              .addToHistory(m.id);
                                          return MovieDetailScreen(
                                            movieId: m.id,
                                          );
                                        },
                                      ),
                                    ),
                              );
                            },
                          );
                        }
                        return Center(
                          child: Image.asset("assets/common/popcorn.png"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
