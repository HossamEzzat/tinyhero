import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../data/food_database.dart';
import '../models/models.dart';
import 'app_storage.dart';

class AppState extends ChangeNotifier {
  AppState(this._storage);

  final AppStorage _storage;
  final _uuid = const Uuid();

  bool loading = true;
  bool onboarded = false;
  ChildProfile? profile;
  List<SugarReading> readings = [];
  List<MealEntry> meals = [];
  ReminderSettings reminders = const ReminderSettings();

  SugarReading? get latestReading => readings.isEmpty ? null : readings.first;

  List<MealEntry> get todayMeals {
    final now = DateTime.now();
    return meals
        .where(
          (m) =>
              m.at.year == now.year &&
              m.at.month == now.month &&
              m.at.day == now.day,
        )
        .toList();
  }

  String get motivation {
    final i = DateTime.now().day % motivationalMessages.length;
    return motivationalMessages[i];
  }

  Future<void> init() async {
    loading = true;
    notifyListeners();
    onboarded = await _storage.isOnboarded();
    profile = await _storage.loadProfile();
    readings = await _storage.loadReadings();
    meals = await _storage.loadMeals();
    reminders = await _storage.loadReminders();
    loading = false;
    notifyListeners();
  }

  Future<void> completeOnboarding(ChildProfile p) async {
    profile = p;
    onboarded = true;
    await _storage.saveProfile(p);
    await _storage.setOnboarded(true);
    notifyListeners();
  }

  Future<void> updateProfile(ChildProfile p) async {
    profile = p;
    await _storage.saveProfile(p);
    notifyListeners();
  }

  Future<void> addReading(SugarReading reading) async {
    readings = [reading, ...readings];
    await _storage.saveReadings(readings);
    notifyListeners();
  }

  Future<void> addMeal(MealEntry meal) async {
    meals = [meal, ...meals];
    await _storage.saveMeals(meals);
    notifyListeners();
  }

  Future<void> updateReminders(ReminderSettings s) async {
    reminders = s;
    await _storage.saveReminders(s);
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.clearAll();
    onboarded = false;
    profile = null;
    readings = [];
    meals = [];
    reminders = const ReminderSettings();
    notifyListeners();
  }

  String newId() => _uuid.v4();

  List<SugarReading> readingsInRange(Duration range) {
    final cutoff = DateTime.now().subtract(range);
    return readings.where((r) => r.at.isAfter(cutoff)).toList();
  }

  double? averageSugar(Duration range) {
    final list = readingsInRange(range);
    if (list.isEmpty) return null;
    return list.map((e) => e.value).reduce((a, b) => a + b) / list.length;
  }
}
