import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/data/models/repository/movie_repository.dart';
import 'package:movies_app/features/main_layer/home/screens/home_tab.dart';
import 'package:movies_app/features/main_layer/search/search_tab/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [
      HomeTab(),
      SearchTab(),
      // BrowseTab(),
      // ProfileTab(),
    ];
  }
  Widget bottomIcon(String asset, {required bool isActive}) {
    return SvgPicture.asset(
      asset,
      width: 30,
      height: 30,
      colorFilter: ColorFilter.mode(
        isActive ? const Color(0xFFF6BD00) : const Color(0xFFFFFFFF),
        BlendMode.srcIn,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MovieRepository(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),

        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF282A28),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF282A28).withOpacity(0.8),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
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
                  icon: bottomIcon('assets/main_layer/home.svg', isActive: false),
                  activeIcon: bottomIcon('assets/main_layer/home.svg', isActive: true),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: bottomIcon('assets/main_layer/search.svg', isActive: false),
                  activeIcon: bottomIcon('assets/main_layer/search.svg', isActive: true),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: bottomIcon('assets/main_layer/explore.svg', isActive: false),
                  activeIcon: bottomIcon('assets/main_layer/explore.svg', isActive: true),
                  label: 'Browse',
                ),
                BottomNavigationBarItem(
                  icon: bottomIcon('assets/main_layer/profile.svg', isActive: false),
                  activeIcon: bottomIcon('assets/main_layer/profile.svg', isActive: true),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}