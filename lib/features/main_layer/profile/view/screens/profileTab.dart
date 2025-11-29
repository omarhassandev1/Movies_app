import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/features/auth/view/login/login_screen.dart';
import 'package:movies_app/features/main_layer/profile/cubit/profile_cubit.dart';
import 'package:movies_app/features/main_layer/profile/cubit/profile_state.dart';
import 'package:movies_app/features/main_layer/profile/profile_features/history_service/cubit/history_state.dart';
import 'package:movies_app/features/main_layer/profile/profile_features/history_service/services/history_service.dart';
import 'package:movies_app/features/main_layer/profile/view/screens/update_profile.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../auth/cubit/auth_cubit.dart';
import '../../profile_features/favorites/cubits/fav_cubit.dart';
import '../../profile_features/favorites/cubits/fav_state.dart';
import '../../profile_features/favorites/view/favs_grid_view.dart';
import '../../profile_features/history_service/cubit/history_cubit.dart';
import '../../profile_features/history_service/view/widgets/history_gridview.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});
  static const String routeName = '/profile';

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  List<int> historyMovies = [];

  void initiateHistory() async {
    historyMovies = await HistoryService.getHistory();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfileData();
    initiateHistory();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: SafeArea(
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
                          final currentUser = state.user;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                          0.12,
                                      backgroundImage: AssetImage(
                                        'assets/common/avaters/avater${currentUser.avaterId}.png',
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BlocBuilder<FavCubit, FavState>(
                                            builder: (context, state) {
                                              int favCount =
                                                  state is FavoriteGetSuccess
                                                      ? state.favMovies.length
                                                      : 0;
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    favCount.toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Text(
                                                    'Watch List',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          BlocBuilder<
                                            HistoryCubit,
                                            HistoryState
                                          >(
                                            builder: (context, state) {
                                              int historyCount =
                                                  state is HistoryLoaded
                                                      ? state.movies.length
                                                      : 0;
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    historyCount.toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Text(
                                                    'History',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  currentUser.name,
                                  style: const TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
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
                                                    child: UpdateProfileScreen(
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
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                            ),
                                            backgroundColor: Colors.white,
                                            builder: (ctx) {
                                              return Container(
                                                color: AppColors.blackColor,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    16.0,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Text(
                                                        'Are you sure you want to logout?',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                ctx,
                                                              ).pop();
                                                            },
                                                            child: const Text(
                                                              'No',
                                                              style: TextStyle(
                                                                color:
                                                                    AppColors
                                                                        .blackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                            onPressed: () async {
                                                              Navigator.of(
                                                                ctx,
                                                              ).pop();
                                                              await context
                                                                  .read<
                                                                    AuthCubit
                                                                  >()
                                                                  .logout();
                                                              Navigator.of(
                                                                context,
                                                              ).pushReplacementNamed(
                                                                LoginScreen
                                                                    .routeName,
                                                              );
                                                            },
                                                            child: const Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                color:
                                                                    AppColors
                                                                        .whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                            color: AppColors.redColor,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              spacing: 5,
                                              children: [
                                                const Text(
                                                  'Log out',
                                                  style: TextStyle(
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ),
                                                Assets.profile.logout.svg(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: TabBar(
                    labelColor: AppColors.mainColor,
                    unselectedLabelColor: AppColors.whiteColor,
                    indicatorColor: AppColors.mainColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        text: 'Watch List',
                        icon: Assets.profile.watchlist.svg(),
                      ),
                      Tab(text: 'History', icon: Assets.profile.history.svg()),
                    ],
                  ),
                ),
              ],
          body: const TabBarView(children: [FavGridView(), HistoryGridview()]),
        ),
      ),
    );
  }
}
