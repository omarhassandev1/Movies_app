import 'package:flutter/material.dart';
import 'package:movies_app/common/theme/app_colors.dart';

import '../../../../data/models/films_response.dart';
import 'film_details.dart';


class Hhorizontallistwidget extends StatefulWidget {
  Hhorizontallistwidget({required this.movie,required this.containerHeight,required this.containerWidth, super.key});
  Movies movie;
  double containerHeight;
  double containerWidth;

  @override
  State<Hhorizontallistwidget> createState() => _HhorizontallistwidgetState();
}

class _HhorizontallistwidgetState extends State<Hhorizontallistwidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, FilmDetails.routeName,
            arguments: widget.movie
        );
      },
      child: SizedBox(
        width: widget.containerWidth,
        height: widget.containerHeight,
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                widget.movie.mediumCoverImage ?? "https://th.bing.com/th/id/OIP.PLKhzDLPYVd_DiqnZkpjPgHaEK?rs=1&pid=ImgDetMain",
                fit: BoxFit.fill,
                height: 350,
              ),
              borderRadius: BorderRadius.circular(20),
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
                    // Image.asset("assets/images/star.png")
                    Icon(Icons.star,color: AppColors.mainColor,)
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