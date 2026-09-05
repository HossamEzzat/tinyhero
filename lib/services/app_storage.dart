import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class AppStorage {
  static const _profileKey = 'profile';
  static const _readingsKey = 'readings';
  static const _mealsKey = 'meals';
  static const _remindersKey = 'reminders';
  static const _onboardedKey = 'onboarded';

  Future<bool> isOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardedKey) ?? false;
  }

  Future<void> setOnboarded(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardedKey, value);
  }

  Future<ChildProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_profileKey);
    if (raw == null) return null;
    return ChildProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveProfile(ChildProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileKey, jsonEncode(profile.toJson()));
  }

  Future<List<SugarReading>> loadReadings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_readingsKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => SugarReading.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.at.compareTo(a.at));
  }

  Future<void> saveReadings(List<SugarReading> readings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _readingsKey,
      jsonEncode(readings.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<MealEntry>> loadMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_mealsKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => MealEntry.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.at.compareTo(a.at));
  }

  Future<void> saveMeals(List<MealEntry> meals) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _mealsKey,
      jsonEncode(meals.map((e) => e.toJson()).toList()),
    );
  }

  Future<ReminderSettings> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_remindersKey);
    if (raw == null) return const ReminderSettings();
    return ReminderSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveReminders(ReminderSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_remindersKey, jsonEncode(settings.toJson()));
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
