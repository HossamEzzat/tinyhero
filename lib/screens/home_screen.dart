import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/food_database.dart';
import '../models/models.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onQuickAdd,
    required this.onQuickInsulin,
    required this.onQuickMeals,
    required this.onQuickReports,
    required this.onEmergency,
  });

  final VoidCallback onQuickAdd;
  final VoidCallback onQuickInsulin;
  final VoidCallback onQuickMeals;
  final VoidCallback onQuickReports;
  final VoidCallback onEmergency;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final profile = state.profile!;
    final reading = state.latestReading;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.skyLight,
                  child: Text(
                    profile.gender == Gender.male ? '👦' : '👧',
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'أهلاً ${profile.name}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        profile.diabetesType == DiabetesType.type1
                            ? 'سكري النوع الأول'
                            : 'سكري النوع الثاني',
                        style: const TextStyle(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onEmergency,
                  icon: const Icon(Icons.health_and_safety_outlined,
                      color: AppColors.red),
                  tooltip: 'إرشادات الطوارئ',
                ),
              ],
            ),
            const SizedBox(height: 16),
            SoftCard(
              color: _statusBg(reading?.status),
              child: Column(
                children: [
                  const Text(
                    'آخر قياس سكر',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 8),
                  if (reading == null)
                    const Text(
                      '—',
                      style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                    )
                  else ...[
                    Text(
                      reading.value.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: _statusColor(reading.status),
                      ),
                    ),
                    const Text('mg/dL'),
                    const SizedBox(height: 6),
                    Text(
                      '${SugarHelpers.statusLabel(reading.status)} ${SugarHelpers.statusEmoji(reading.status)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _statusColor(reading.status),
                      ),
                    ),
                  ],
                  if (reading != null && reading.status != SugarStatus.normal) ...[
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: onEmergency,
                      icon: const Icon(Icons.info_outline),
                      label: Text(
                        reading.status == SugarStatus.low
                            ? 'ماذا أفعل في الهبوط؟'
                            : 'ماذا أفعل في الارتفاع؟',
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QuickAction(
                  icon: Icons.bloodtype,
                  label: 'قياس',
                  color: AppColors.skyDark,
                  onTap: onQuickAdd,
                ),
                QuickAction(
                  icon: Icons.calculate,
                  label: 'أنسولين',
                  color: AppColors.orange,
                  onTap: onQuickInsulin,
                ),
                QuickAction(
                  icon: Icons.restaurant,
                  label: 'وجبات',
                  color: AppColors.green,
                  onTap: onQuickMeals,
                ),
                QuickAction(
                  icon: Icons.show_chart,
                  label: 'تقارير',
                  color: AppColors.sky,
                  onTap: onQuickReports,
                ),
              ],
            ),
            const SizedBox(height: 18),
            SoftCard(
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.orangeSoft,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.alarm, color: AppColors.orange),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'الأنسولين القاعدي',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'الموعد: ${profile.basalTime ?? '—'}',
                          style: const TextStyle(color: AppColors.textMuted),
                        ),
                        Text(
                          _basalCountdown(profile.basalTime),
                          style: const TextStyle(
                            color: AppColors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SoftCard(
              color: AppColors.skyLight,
              child: Row(
                children: [
                  const Text('🦸', style: TextStyle(fontSize: 36)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      state.motivation,
                      style: const TextStyle(height: 1.4, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('معامل الكارب الحالي'),
                  const SizedBox(height: 6),
                  Text(
                    '${profile.carbRatio} جرام كارب لكل وحدة أنسولين',
                    style: const TextStyle(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'يمكن تعديله من الملف الشخصي لأنه يتغير حسب الطبيب',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(SugarStatus? s) => switch (s) {
        SugarStatus.low => AppColors.yellow,
        SugarStatus.high => AppColors.red,
        SugarStatus.normal => AppColors.green,
        null => AppColors.text,
      };

  Color _statusBg(SugarStatus? s) => switch (s) {
        SugarStatus.low => AppColors.yellowSoft,
        SugarStatus.high => AppColors.redSoft,
        SugarStatus.normal => AppColors.greenSoft,
        null => AppColors.card,
      };

  String _basalCountdown(String? hhmm) {
    if (hhmm == null || !hhmm.contains(':')) return 'حدّد الموعد من الملف';
    final parts = hhmm.split(':');
    final now = DateTime.now();
    var target = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
    if (!target.isAfter(now)) {
      target = target.add(const Duration(days: 1));
    }
    final diff = target.difference(now);
    final h = diff.inHours.toString().padLeft(2, '0');
    final m = (diff.inMinutes % 60).toString().padLeft(2, '0');
    final s = (diff.inSeconds % 60).toString().padLeft(2, '0');
    return 'متبقي $h:$m:$s';
  }
}
