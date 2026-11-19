import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/food_database.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'insulin_calculator_screen.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meals = context.watch<AppState>().todayMeals;

    final carbs = meals.fold<double>(0, (sum, meal) => sum + meal.totalCarbs);
    final units = meals.fold<double>(0, (sum, meal) => sum + meal.insulinUnits);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          children: [
            ScreenHeader(
              title: 'وجبات اليوم',
              subtitle: meals.isEmpty
                  ? 'لسه مفيش حاجة متسجلة'
                  : '${meals.length} أصناف',
              trailing: IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.skyDark,
                  foregroundColor: Colors.white,
                ),
                tooltip: 'حاسبة',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const InsulinCalculatorScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ),
            if (meals.isNotEmpty) ...[
              Row(
                children: [
                  Expanded(
                    child: _stat(
                      'الكارب',
                      '${carbs.toStringAsFixed(0)} جم',
                      AppColors.orangeSoft,
                      AppColors.orange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _stat(
                      'الأنسولين',
                      '${units.toStringAsFixed(1)} وحدة',
                      AppColors.skyLight,
                      AppColors.skyDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
            SoftCard(
              color: AppColors.orangeSoft,
              child: Row(
                children: [
                  const Icon(
                    Icons.notifications_active,
                    color: AppColors.orange,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'بعد الأكل: فعّل تذكير قياس السكر (من شاشة التنبيهات)',
                      style: TextStyle(height: 1.35),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            if (meals.isEmpty) ...[
              const EmptyHint(
                'مفيش وجبات النهاردة.\nاستخدم الحاسبة واختر الأكل من القوائم.',
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const InsulinCalculatorScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.calculate_outlined),
                label: const Text('احسب وجبة'),
              ),
            ] else
              ...meals.map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SoftCard(
                    child: Row(
                      children: [
                        Text(
                          FoodDatabase.categoryEmoji(m.category),
                          style: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m.foodName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${m.grams.toStringAsFixed(0)} جرام · كارب ${m.totalCarbs.toStringAsFixed(1)}g',
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                ),
                              ),
                              Text(
                                '${m.at.hour.toString().padLeft(2, '0')}:${m.at.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              m.insulinUnits.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.skyDark,
                              ),
                            ),
                            const Text('وحدة', style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            const SoftCard(
              child: Text(
                'القوائم تشمل: خضار، فاكهة، ألبان، وجبات رئيسية، مخبوزات، حلويات، وأكلات لا تُحسب. تقدر تضيف أكثر من صنف في الحاسبة وتبحث بالاسم.',
                style: TextStyle(color: AppColors.textMuted, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value, Color bg, Color fg) {
    return SoftCard(
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
