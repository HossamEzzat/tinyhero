import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'emergency_guides_screen.dart';
import 'injection_sites_screen.dart';
import 'reminders_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final p = state.profile!;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          children: [
            const ScreenHeader(
              title: 'المزيد',
              subtitle: 'الملف، التنبيهات، والإرشادات',
            ),
            SoftCard(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.skyLight,
                    child: Text(
                      p.gender == Gender.male ? '👦' : '👧',
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${p.age} سنة · ${p.diabetesType == DiabetesType.type1 ? 'النوع الأول' : 'النوع الثاني'}',
                        ),
                        Text(
                          'معامل الكارب: ${p.carbRatio}',
                          style: const TextStyle(
                            color: AppColors.skyDark,
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
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit, color: AppColors.skyDark),
                    title: const Text('تعديل الملف / معامل الكارب'),
                    trailing: const Icon(Icons.chevron_left),
                    onTap: () => _editProfile(context, p),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.notifications_active,
                      color: AppColors.orange,
                    ),
                    title: const Text('المنبّه والتنبيهات'),
                    trailing: const Icon(Icons.chevron_left),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RemindersScreen(),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.health_and_safety,
                      color: AppColors.red,
                    ),
                    title: const Text('إرشادات الهبوط والارتفاع'),
                    trailing: const Icon(Icons.chevron_left),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const EmergencyGuidesScreen(),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.vaccines_outlined,
                      color: AppColors.skyDark,
                    ),
                    title: const Text('أماكن الحقن'),
                    subtitle: const Text('٤ مناطق ندوّر بينها'),
                    trailing: const Icon(Icons.chevron_left),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const InjectionSitesScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SoftCard(
              color: AppColors.redSoft,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout, color: AppColors.red),
                title: const Text('مسح البيانات والبدء من جديد'),
                onTap: () async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('تأكيد'),
                      content: const Text('سيتم حذف الملف والقياسات والوجبات.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('إلغاء'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('حذف'),
                        ),
                      ],
                    ),
                  );
                  if (ok == true && context.mounted) {
                    await context.read<AppState>().logout();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editProfile(BuildContext context, ChildProfile p) async {
    final nameCtrl = TextEditingController(text: p.name);
    final ageCtrl = TextEditingController(text: '${p.age}');
    final ratioCtrl = TextEditingController(text: '${p.carbRatio}');
    var gender = p.gender;
    var type = p.diabetesType;
    var basal = p.basalTime ?? '20:30';

    final saved = await showModalBottomSheet<ChildProfile>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModal) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                16,
                20,
                20 + MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'تعديل الملف',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(labelText: 'الاسم'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: ageCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'العمر'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: ratioCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'معامل الكارب',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<Gender>(
                            initialValue: gender,
                            items: const [
                              DropdownMenuItem(
                                value: Gender.male,
                                child: Text('ذكر'),
                              ),
                              DropdownMenuItem(
                                value: Gender.female,
                                child: Text('أنثى'),
                              ),
                            ],
                            onChanged: (v) =>
                                setModal(() => gender = v ?? gender),
                            decoration: const InputDecoration(
                              labelText: 'النوع',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<DiabetesType>(
                            initialValue: type,
                            items: const [
                              DropdownMenuItem(
                                value: DiabetesType.type1,
                                child: Text('نوع 1'),
                              ),
                              DropdownMenuItem(
                                value: DiabetesType.type2,
                                child: Text('نوع 2'),
                              ),
                            ],
                            onChanged: (v) => setModal(() => type = v ?? type),
                            decoration: const InputDecoration(
                              labelText: 'السكري',
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('الأنسولين القاعدي'),
                      subtitle: Text(basal),
                      trailing: TextButton(
                        onPressed: () async {
                          final parts = basal.split(':');
                          final picked = await showTimePicker(
                            context: ctx,
                            initialTime: TimeOfDay(
                              hour: int.parse(parts[0]),
                              minute: int.parse(parts[1]),
                            ),
                          );
                          if (picked != null) {
                            setModal(() {
                              basal =
                                  '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                            });
                          }
                        },
                        child: const Text('تغيير'),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        final age = int.tryParse(ageCtrl.text);
                        final ratio = double.tryParse(ratioCtrl.text);
                        if (nameCtrl.text.trim().isEmpty ||
                            age == null ||
                            ratio == null ||
                            ratio <= 0) {
                          return;
                        }
                        Navigator.pop(
                          ctx,
                          p.copyWith(
                            name: nameCtrl.text.trim(),
                            age: age,
                            gender: gender,
                            diabetesType: type,
                            carbRatio: ratio,
                            basalTime: basal,
                          ),
                        );
                      },
                      child: const Text('حفظ'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (saved != null && context.mounted) {
      await context.read<AppState>().updateProfile(saved);
    }
  }
}
