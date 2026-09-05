import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final r = state.reminders;

    return Scaffold(
      appBar: AppBar(title: const Text('المنبّه والتنبيهات')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            child: Column(
              children: [
                SwitchListTile(
                  value: r.basalInsulin,
                  onChanged: (v) => state.updateReminders(r.copyWith(basalInsulin: v)),
                  title: const Text('الأنسولين القاعدي'),
                  subtitle: Text('الموعد: ${state.profile?.basalTime ?? '—'}'),
                  secondary: const Icon(Icons.alarm, color: AppColors.orange),
                ),
                const Divider(),
                SwitchListTile(
                  value: r.sugarCheck,
                  onChanged: (v) => state.updateReminders(r.copyWith(sugarCheck: v)),
                  title: const Text('قياس السكر'),
                  subtitle: const Text('تذكير دوري خلال اليوم'),
                  secondary: const Icon(Icons.bloodtype, color: AppColors.skyDark),
                ),
                const Divider(),
                SwitchListTile(
                  value: r.afterMeal,
                  onChanged: (v) => state.updateReminders(r.copyWith(afterMeal: v)),
                  title: const Text('بعد الأكل'),
                  subtitle: const Text('قياس السكر بعد الوجبة'),
                  secondary: const Icon(Icons.restaurant, color: AppColors.green),
                ),
                const Divider(),
                SwitchListTile(
                  value: r.water,
                  onChanged: (v) => state.updateReminders(r.copyWith(water: v)),
                  title: const Text('شرب المياه'),
                  secondary: const Icon(Icons.water_drop, color: Colors.lightBlue),
                ),
                const Divider(),
                SwitchListTile(
                  value: r.labs,
                  onChanged: (v) => state.updateReminders(r.copyWith(labs: v)),
                  title: const Text('مواعيد التحاليل'),
                  subtitle: const Text('تقريبًا كل 3 شهور أو حسب الطبيب'),
                  secondary: const Icon(Icons.biotech, color: Colors.purple),
                ),
                const Divider(),
                SwitchListTile(
                  value: r.sugarFluctuation,
                  onChanged: (v) =>
                      state.updateReminders(r.copyWith(sugarFluctuation: v)),
                  title: const Text('تنبيه ذبذبة السكر'),
                  subtitle: const Text('تذكير بمخاطر الصعود والهبوط المفاجئ'),
                  secondary: const Icon(Icons.warning_amber_rounded, color: AppColors.red),
                ),
              ],
            ),
          ),
          if (r.sugarFluctuation) ...[
            const SizedBox(height: 12),
            SoftCard(
              color: AppColors.yellowSoft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '⚠️ مخاطر الذبذبة',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'السكر لما يطلع وينزل بسرعة ممكن يسبب دوخة، تعب، صعوبة تركيز، أو خوف عند الطفل.',
                    style: TextStyle(height: 1.45),
                  ),
                  SizedBox(height: 8),
                  Text('• قيس بانتظام وما تستناش الأعراض بس.', style: TextStyle(height: 1.4)),
                  Text('• بعد الرياضة أو الأكل السكري راقب أكتر.', style: TextStyle(height: 1.4)),
                  Text('• لو في هبوط/ارتفاع متكرر: راجع الخطة مع الطبيب.', style: TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          const SoftCard(
            color: AppColors.skyLight,
            child: Text(
              'التفضيلات محفوظة محليًا. عدّل موعد الأنسولين القاعدي من الملف الشخصي، ورسائل التشجيع تظهر في الرئيسية كل يوم.',
              style: TextStyle(height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}
