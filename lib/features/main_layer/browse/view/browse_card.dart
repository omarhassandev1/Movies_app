import 'package:flutter/material.dart';
import 'package:movies_app/common/theme/app_colors.dart';

import '../../../../data/models/films_response.dart';
import '../../../movie_details/view/film_details.dart';


class BrowseCard extends StatefulWidget {
  BrowseCard({required this.movie,required this.containerHeight,required this.containerWidth, super.key});
  Movies movie;
  double containerHeight;
  double containerWidth;

  @override
  State<BrowseCard> createState() => _BrowseCardState();
}

class _BrowseCardState extends State<BrowseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.movie.id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilmDetails(movieId: widget.movie.id!),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Movie ID is not available")),
          );
        }
      },
      child: SizedBox(
        width: widget.containerWidth,
        height: widget.containerHeight,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.movie.mediumCoverImage ?? "https://th.bing.com/th/id/OIP.PLKhzDLPYVd_DiqnZkpjPgHaEK?rs=1&pid=ImgDetMain",
                fit: BoxFit.fill,
                height: 350,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8,left: 8),
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:const Color(0xff282A28)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.movie.rating.toString(),style: Theme.of(context).textTheme.bodySmall,),
                    const Icon(Icons.star,color: AppColors.mainColor,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}