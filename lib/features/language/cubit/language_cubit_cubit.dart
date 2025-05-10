import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_cubit_state.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  void _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('lang_code') ?? 'en';
    emit(Locale(savedLang));
  }

  void toggleLanguage() async {
    final isArabic = state.languageCode == 'ar';
    final newLocale = isArabic ? const Locale('en') : const Locale('ar');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang_code', newLocale.languageCode);

    emit(newLocale);
  }
}
