// import 'package:flutter_riverpod/legacy.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final languageProvider = StateNotifierProvider<LanguageNotifier, bool>((ref) {
//   return LanguageNotifier();
// });

// class LanguageNotifier extends StateNotifier<bool> {
//   // false = español
//   // true = inglés

//   LanguageNotifier() : super(false) {
//     loadLanguage();
//   }

//   void loadLanguage() async {
//     final prefs = await SharedPreferences.getInstance();

//     state = prefs.getBool('isEnglish') ?? false;
//   }

//   void toggleLanguage() async {
//     final prefs = await SharedPreferences.getInstance();

//     state = !state;

//     await prefs.setBool('isEnglish', state);
//   }
// }
