import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'package:movies_app/features/main_layer/browse/view/browse_tab.dart';
import 'package:movies_app/features/main_layer/home/screens/home_tab.dart';
import 'package:movies_app/features/main_layer/search/search_tab/search_tab.dart';
import 'profile/view/screens/profileTab.dart';

class MainLayer extends StatefulWidget {
  const MainLayer({super.key});
  static const String routeName = '/homeScreen';

  @override
  State<MainLayer> createState() => _MainLayerState();
}

class _MainLayerState extends State<MainLayer> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeTab(),
      const SearchTab(),
      const BrowseTab(),
      const ProfileTab(),
    ];
  }

  Widget bottomIcon(String asset, {required bool isActive}) {
    return SvgPicture.asset(
      asset,
      width: 30,
      height: 30,
      colorFilter: ColorFilter.mode(
        isActive ? AppColors.mainColor : AppColors.whiteColor,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MovieRepository(),
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),

        bottomNavigationBar: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF282A28),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (i) => setState(() => _currentIndex = i),
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: const Color(0xFFF6BD00),
                unselectedItemColor: const Color(0xFFFFFFFF),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: bottomIcon(
                      'assets/main_layer/home.svg',
                      isActive: false,
                    ),
                    activeIcon: bottomIcon(
                      'assets/main_layer/home.svg',
                      isActive: true,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: bottomIcon(
                      'assets/main_layer/search.svg',
                      isActive: false,
                    ),
                    activeIcon: bottomIcon(
                      'assets/main_layer/search.svg',
                      isActive: true,
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: bottomIcon(
                      'assets/main_layer/explore.svg',
                      isActive: false,
                    ),
                    activeIcon: bottomIcon(
                      'assets/main_layer/explore.svg',
                      isActive: true,
                    ),
                    label: 'Browse',
                  ),
                  BottomNavigationBarItem(
                    icon: bottomIcon(
                      'assets/main_layer/profile.svg',
                      isActive: false,
                    ),
                    activeIcon: bottomIcon(
                      'assets/main_layer/profile.svg',
                      isActive: true,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
