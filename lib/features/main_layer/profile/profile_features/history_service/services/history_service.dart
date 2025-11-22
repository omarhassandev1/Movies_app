import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String _key = "watch_history";

  static Future<List<int>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? [];

    return stored.map((e) => int.parse(e)).toList();
  }

  static Future<void> addToHistory(int movieId) async {
    final prefs = await SharedPreferences.getInstance();

    final stored = prefs.getStringList(_key) ?? [];
    final idStr = movieId.toString();

    if (!stored.contains(idStr)) {
      stored.insert(0, idStr);
      await prefs.setStringList(_key, stored);
    }
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
