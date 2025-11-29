import 'package:flutter/material.dart';
import '../../../data/services/api_manager.dart';
import '../../main_layer/browse/view/browse_card.dart';
class SuggestedMoviesList extends StatelessWidget {
  const SuggestedMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSuggestions(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError)
        {
          return Center(child: Text("Error"));
        }
        else {
          var sugesstedData = snapshot.data?.data?.movies ?? [];
          return SizedBox(
            height: 180,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return BrowseCard(
                    movie: sugesstedData[index],
                    containerHeight: 220,
                    containerWidth: 120,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 20,),
                itemCount: sugesstedData.length
            ),
          );
        }
      },
    );
  }
}