import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/features/movie_details/view/suggested_films_list.dart';
import 'package:movies_app/features/main_layer/profile/profile_features/history_service/cubit/history_cubit.dart';
import 'package:movies_app/features/movie_details/view/web_view_app.dart';
import '../../../data/models/films_response.dart';
import '../../../data/services/api_manager.dart';

class FilmDetails extends StatefulWidget {
  final int movieId;

  const FilmDetails({super.key, required this.movieId});

  @override
  State<FilmDetails> createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  Movies? movie;
  bool isLoading = true;
  String? error;
  Color iconColor = Colors.white;

  @override
  void initState() {
    super.initState();
    fetchMovie();
  }

  void fetchMovie() async {
    try {
      final response = await ApiManager.getMovieDetails(widget.movieId);
      if (response != null) {
        setState(() {
          movie = response;
          isLoading = false;
        });
      } else {
        setState(() {
          error = "Movie data not found";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  String getValidImageUrl(String? url) {
    return (url == null || url.isEmpty)
        ? "https://th.bing.com/th/id/OIP.PLKhzDLPYVd_DiqnZkpjPgHaEK?rs=1&pid=ImgDetMain"
        : url;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(child: Text("Error: $error")),
      );
    }

    if (movie == null) {
      return const Scaffold(
        body: Center(child: Text("Movie not available")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.65,
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    getValidImageUrl(movie?.mediumCoverImage),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          AppColors.darkGray.withOpacity(0.2),
                          const Color(0xff000000).withOpacity(0.92),
                        ],
                        stops: const [0.0, 0.95],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            // context.read<FavCubit>().
                          },
                          icon: Icon(Icons.bookmark_outlined,
                              color: iconColor, size: 40),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.05,
                    child: Text(
                      movie?.title ?? "Unknown Title",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Text(
                      movie?.year?.toString() ?? "N/A",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xffADADAD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<HistoryCubit>().addToHistory(movie!.id!);
                    if (movie?.url != null && movie!.url!.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewApp(
                            url: movie!.url!,
                            title: movie!.title ?? "",
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Movie URL not available")),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.redColor),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  child: const Text(
                    "Watch",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 47,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: double.infinity,
                    width: width * 0.28,
                    decoration: BoxDecoration(
                      color: AppColors.darkGray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite),
                          color: AppColors.mainColor,
                        ),
                        const Text(
                          "15",
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: width * 0.28,
                    decoration: BoxDecoration(
                      color: AppColors.darkGray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.timelapse, color: AppColors.mainColor),
                        Text(
                          movie?.runtime?.toString() ?? "N/A",
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: width * 0.28,
                    decoration: BoxDecoration(
                      color: AppColors.darkGray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.star, color: AppColors.mainColor),
                        Text(
                          movie?.rating?.toString() ?? "N/A",
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Screen Shots",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  for (var img in [
                    movie?.smallCoverImage,
                    movie?.mediumCoverImage,
                    movie?.largeCoverImage
                  ].where((e) => e != null))
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(16)),
                        child: SizedBox(
                          width: double.infinity,
                          height: height * 0.18,
                          child:
                          Image.network(getValidImageUrl(img), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Similar",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const SuggestedMoviesList(),

            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Summary",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(movie?.summary?.isEmpty ?? true
                  ? "No Summary to this movie"
                  : movie!.summary!),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
