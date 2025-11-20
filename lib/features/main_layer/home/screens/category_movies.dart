import 'package:flutter/material.dart';
import 'package:movies_app/features/main_layer/search/search_tab/search_tab.dart';
class CategoryMoviesScreen extends StatelessWidget {
  final String title;
  final Map<String, dynamic> params;
  const CategoryMoviesScreen({
    super.key,
    required this.title,
    required this.params,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SearchTab(initialParams: params),
    );
  }
}