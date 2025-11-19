import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/data/models/user_model.dart';
import 'package:movies_app/features/favorites/cubits/fav_cubit.dart';
import 'package:movies_app/features/favorites/cubits/fav_state.dart';
import 'package:movies_app/features/main_layer/profile/cubit/profile_cubit.dart';
import 'package:movies_app/features/main_layer/profile/cubit/profile_state.dart';
import 'package:movies_app/features/main_layer/profile/view/screens/update_profile.dart';
import 'package:flutter/services.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../favorites/view/favs_grid_view.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});
  static const String routeName = '/profile';

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    late UserModel currentUser;

    return DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: AppColors.blackColor,
                body: Column(
                  children: [
                    SafeArea(
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return const SizedBox(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.mainColor,
                                ),
                              ),
                            );
                          } else if (state is ProfileGetSuccess) {
                            currentUser = state.user;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                spacing: 20,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: screenWidth * 0.12,
                                        backgroundImage: AssetImage(
                                          'assets/common/avaters/avater${currentUser.avaterId}.png',
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.05),
                                      Expanded(
                                        child: BlocBuilder<FavCubit,FavState>(
                                          builder: (context, state) {
                                            int favCount = 0;

                                            if (state is FavoriteGetSuccess) {
                                              favCount = state.favMovies.length;
                                            }
                                            return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    favCount.toString(),
                                                    style: TextStyle(
                                                      color: AppColors.whiteColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize:
                                                          screenWidth * 0.06,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenWidth * 0.015,
                                                  ),
                                                  Text(
                                                    'Watch List',
                                                    style: TextStyle(
                                                      color: AppColors.whiteColor,
                                                      fontSize:
                                                          screenWidth * 0.035,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '10',
                                                    style: TextStyle(
                                                      color: AppColors.whiteColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize:
                                                          screenWidth * 0.06,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenWidth * 0.015,
                                                  ),
                                                  Text(
                                                    'History',
                                                    style: TextStyle(
                                                      color: AppColors.whiteColor,
                                                      fontSize:
                                                          screenWidth * 0.035,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    currentUser.name,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CustomMainButton(
                                          text: 'Edit Profile',
                                          onPressed: () async {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => BlocProvider.value(
                                                      value:
                                                          context
                                                              .read<
                                                                ProfileCubit
                                                              >(),
                                                      child:
                                                          UpdateProfileScreen(
                                                            user: currentUser,
                                                          ),
                                                    ),
                                              ),
                                            );

                                            if (result == true) {
                                              context
                                                  .read<ProfileCubit>()
                                                  .getProfileData();
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            SystemChannels.platform
                                                .invokeMethod(
                                                  'SystemNavigator.pop',
                                                );
                                          },
                                          child: Container(
                                            height: 55,
                                            decoration: BoxDecoration(
                                              color: AppColors.redColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  Assets.profile.logout.path,
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
                                ],
                              ),
                            );
                          } else if (state is ProfileError) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: AppColors.redColor,
                                      size: 30,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      state.errorMessage,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),

                    TabBar(
                      labelColor: AppColors.mainColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: AppColors.mainColor,
                      unselectedLabelColor: AppColors.whiteColor,
                      tabs: [
                        Tab(
                          text: "Watch List",
                          icon: Assets.profile.watchlist.svg(
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Tab(
                          text: "History",
                          icon: Assets.profile.history.svg(
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          const Column(
                            children: [
                              FavGridView(),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Assets.common.popcorn.image()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
