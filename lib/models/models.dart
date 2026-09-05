enum Gender { male, female }

enum DiabetesType { type1, type2 }

enum SugarStatus { low, normal, high }

enum FoodCategory {
  vegetables,
  fruits,
  dairy,
  mainMeals,
  bakery,
  sweets,
  protein,
}

class ChildProfile {
  final String name;
  final int age;
  final Gender gender;
  final DiabetesType diabetesType;
  final double carbRatio;
  final String? basalTime; // HH:mm

  const ChildProfile({
    required this.name,
    required this.age,
    required this.gender,
    required this.diabetesType,
    required this.carbRatio,
    this.basalTime,
  });

  ChildProfile copyWith({
    String? name,
    int? age,
    Gender? gender,
    DiabetesType? diabetesType,
    double? carbRatio,
    String? basalTime,
  }) {
    return ChildProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      diabetesType: diabetesType ?? this.diabetesType,
      carbRatio: carbRatio ?? this.carbRatio,
      basalTime: basalTime ?? this.basalTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'gender': gender.name,
        'diabetesType': diabetesType.name,
        'carbRatio': carbRatio,
        'basalTime': basalTime,
      };

  factory ChildProfile.fromJson(Map<String, dynamic> json) => ChildProfile(
        name: json['name'] as String,
        age: json['age'] as int,
        gender: Gender.values.byName(json['gender'] as String),
        diabetesType: DiabetesType.values.byName(json['diabetesType'] as String),
        carbRatio: (json['carbRatio'] as num).toDouble(),
        basalTime: json['basalTime'] as String?,
      );
}

class SugarReading {
  final String id;
  final double value;
  final DateTime at;
  final String? note;
  final int? mood; // 0 happy .. 3 sick

  const SugarReading({
    required this.id,
    required this.value,
    required this.at,
    this.note,
    this.mood,
  });

  SugarStatus get status {
    if (value < 80) return SugarStatus.low;
    if (value >= 180) return SugarStatus.high;
    return SugarStatus.normal;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'at': at.toIso8601String(),
        'note': note,
        'mood': mood,
      };

  factory SugarReading.fromJson(Map<String, dynamic> json) => SugarReading(
        id: json['id'] as String,
        value: (json['value'] as num).toDouble(),
        at: DateTime.parse(json['at'] as String),
        note: json['note'] as String?,
        mood: json['mood'] as int?,
      );
}

class MealEntry {
  final String id;
  final String foodName;
  final FoodCategory category;
  final double carbPerGram;
  final double grams;
  final DateTime at;
  final double insulinUnits;

  const MealEntry({
    required this.id,
    required this.foodName,
    required this.category,
    required this.carbPerGram,
    required this.grams,
    required this.at,
    required this.insulinUnits,
  });

  double get totalCarbs => carbPerGram * grams;

  Map<String, dynamic> toJson() => {
        'id': id,
        'foodName': foodName,
        'category': category.name,
        'carbPerGram': carbPerGram,
        'grams': grams,
        'at': at.toIso8601String(),
        'insulinUnits': insulinUnits,
      };

  factory MealEntry.fromJson(Map<String, dynamic> json) {
    final raw = json['category'] as String;
    final category = raw == 'egyptian'
        ? FoodCategory.mainMeals
        : FoodCategory.values.byName(raw);
    return MealEntry(
      id: json['id'] as String,
      foodName: json['foodName'] as String,
      category: category,
      carbPerGram: (json['carbPerGram'] as num).toDouble(),
      grams: (json['grams'] as num).toDouble(),
      at: DateTime.parse(json['at'] as String),
      insulinUnits: (json['insulinUnits'] as num).toDouble(),
    );
  }
}

class FoodItem {
  final String name;
  final FoodCategory category;
  final double carbPerGram;

  const FoodItem({
    required this.name,
    required this.category,
    required this.carbPerGram,
  });
}

class ReminderSettings {
  final bool basalInsulin;
  final bool sugarCheck;
  final bool afterMeal;
  final bool water;
  final bool labs;
  final bool sugarFluctuation;

  const ReminderSettings({
    this.basalInsulin = true,
    this.sugarCheck = true,
    this.afterMeal = true,
    this.water = true,
    this.labs = true,
    this.sugarFluctuation = true,
  });

  ReminderSettings copyWith({
    bool? basalInsulin,
    bool? sugarCheck,
    bool? afterMeal,
    bool? water,
    bool? labs,
    bool? sugarFluctuation,
  }) {
    return ReminderSettings(
      basalInsulin: basalInsulin ?? this.basalInsulin,
      sugarCheck: sugarCheck ?? this.sugarCheck,
      afterMeal: afterMeal ?? this.afterMeal,
      water: water ?? this.water,
      labs: labs ?? this.labs,
      sugarFluctuation: sugarFluctuation ?? this.sugarFluctuation,
    );
  }

  Map<String, dynamic> toJson() => {
        'basalInsulin': basalInsulin,
        'sugarCheck': sugarCheck,
        'afterMeal': afterMeal,
        'water': water,
        'labs': labs,
        'sugarFluctuation': sugarFluctuation,
      };

  factory ReminderSettings.fromJson(Map<String, dynamic> json) => ReminderSettings(
        basalInsulin: json['basalInsulin'] as bool? ?? true,
        sugarCheck: json['sugarCheck'] as bool? ?? true,
        afterMeal: json['afterMeal'] as bool? ?? true,
        water: json['water'] as bool? ?? true,
        labs: json['labs'] as bool? ?? true,
        sugarFluctuation: json['sugarFluctuation'] as bool? ?? true,
      );
}
