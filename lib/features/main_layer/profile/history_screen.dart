import 'package:flutter/material.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/features/main_layer/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static const String routeName = '/history';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final List<String> movies = [
      'assets/common/avaters/avater1.png',
      'assets/common/avaters/avater2.png',
      'assets/common/avaters/avater3.png',
    ];

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ----------- TOP BAR -----------
            Container(
              color: AppColors.darkGray,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
              child: Row(
                children: [

                  // ********* LEFT - WATCH LIST *********
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, ProfileScreen.routeName);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/profile/watchlist.svg',
                            height: 30,
                            color: AppColors.mainColor,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Watch List',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ********* RIGHT - HISTORY *********
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/profile/history.svg',
                          height: 30,
                          color: AppColors.mainColor,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'History',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 80,         
                          height: 3,          
                          color: AppColors.mainColor, 
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ----------- GRID OF MOVIES -----------
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: GridView.builder(
                  itemCount: movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.03,
                    mainAxisSpacing: screenWidth * 0.03,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      child: Image.asset(
                        movies[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}



