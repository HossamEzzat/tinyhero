# Tiny Hero

**مساعد السكري للبطل الصغير** — a child-friendly diabetes companion for parents and kids.

Tiny Hero is a Flutter app (Arabic, RTL) that helps families log blood sugar, estimate meal insulin
from carbs, and keep everyday diabetes routines in one place. Data stays on the device. It is a
helper, not a replacement for a doctor’s plan.

## Features

- **Child profile** — name, age, diabetes type (1 or 2), carb ratio (grams of carb per insulin
  unit), and basal insulin time
- **Blood sugar log** — readings in mg/dL with optional note and mood; color-coded as low (&lt; 80),
  in range (80–179), or high (≥ 180)
- **Insulin calculator** — build a meal from the food list, or enter carbs by hand; estimate =
  `total carbs ÷ carb ratio`
- **Food database** — ~200 items (vegetables, fruits, dairy, Egyptian/main meals, bakery, sweets,
  protein) with carbs per gram
- **Today’s meals** — saved meals with carbs and estimated units
- **Reports** — 30- or 90-day average, trend chart, and low / in-range / high split
- **Emergency guides** — hypo, hyper, and rapid swings: symptoms and first steps for families
- **Injection sites** — rotate among abdomen, arm, thigh, and hip
- **Reminder preferences** — basal insulin, sugar checks, after-meal, water, labs, fluctuation
  tips (stored locally)
- **Privacy** — profile, readings, meals, and settings in `SharedPreferences`; no account or cloud
  backend

## Screens

| Tab / flow | What it does                                                |
|------------|-------------------------------------------------------------|
| الرئيسية   | Greeting, latest reading, carb ratio, shortcuts             |
| الوجبات    | Meals logged today                                          |
| + (FAB)    | Quick add: reading, calculator, or reminders                |
| التقارير   | Averages and charts                                         |
| المزيد     | Edit profile, reminders, guides, injection sites, wipe data |

On first launch, onboarding collects the child’s profile before the home shell.

## Tech stack

|             |                                                       |
|-------------|-------------------------------------------------------|
| SDK         | Dart `^3.12.1`, Flutter                               |
| State       | `provider`                                            |
| Persistence | `shared_preferences`                                  |
| Charts      | `fl_chart`                                            |
| i18n        | `flutter_localizations` + `intl` (UI is Arabic / RTL) |
| IDs         | `uuid`                                                |

## Project layout

```
lib/
  main.dart                 # App, RTL, onboarding vs shell
  models/models.dart        # Profile, readings, meals, reminders
  data/food_database.dart   # Foods + insulin math helpers
  services/
    app_state.dart          # In-memory state + persistence
    app_storage.dart        # SharedPreferences JSON
  screens/                  # Home, meals, reports, calculator, …
  theme/app_theme.dart
  widgets/common.dart
```

```

## Medical notice

Tiny Hero is **not medical advice**. Insulin estimates, carb values, and emergency text are educational only. Always follow the child’s clinician for ratios, correction doses, ketone checks, and emergencies.

## License

by Hossam Ezzat Abo Rooka.
