import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _pages = [
      const HomeTab(),
      const SearchTab(),
      // const BrowseTab(),
      // const ProfileTab(),
    ];
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.black,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Browse'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}