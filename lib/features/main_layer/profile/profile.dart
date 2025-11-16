import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/features/main_layer/profile/ubdate_profile.dart';
import 'package:movies_app/features/main_layer/profile/history_screen.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: AppColors.darkGray,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.12,
                              backgroundImage: const AssetImage(
                                  'assets/common/avaters/avater1.png'),
                            ),
                            SizedBox(height: screenWidth * 0.03),
                            const Text(
                              'John Safwat',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.06,
                                    ),
                                  ),
                                  SizedBox(height: screenWidth * 0.015),
                                  Text(
                                    'Watch List',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '10',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.06,
                                    ),
                                  ),
                                  SizedBox(height: screenWidth * 0.015),
                                  Text(
                                    'History',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomMainButton(
                            text: 'Edit Profile',
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, UpdateProfileScreen.routeName);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Exit',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SvgPicture.asset(
                                    'assets/profile/logout.svg',
                                    width: 22,
                                    height: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/profile/watchlist.svg',
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Watch List',
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: double.infinity,
                                  height: 2,
                                  color: AppColors.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HistoryScreen()),
                              );
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/profile/history.svg',
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'History',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: double.infinity,
                                  height: 2,
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/common/popcorn.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





  


