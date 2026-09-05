import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _ratioCtrl = TextEditingController(text: '10');
  Gender _gender = Gender.male;
  DiabetesType _type = DiabetesType.type1;
  TimeOfDay _basal = const TimeOfDay(hour: 20, minute: 30);

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _ratioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.sky, AppColors.skyDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🦸', style: TextStyle(fontSize: 40)),
                      SizedBox(height: 4),
                      Text(
                        'Tiny Hero',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'مساعد السكري للبطل الصغير',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'إنشاء الملف',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'سجّل بيانات الطفل ومعامل الكارب (قابل للتعديل لاحقًا)',
                  style: TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'الاسم',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'اكتب الاسم' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _ageCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'العمر (بالسنين)',
                    prefixIcon: Icon(Icons.cake_outlined),
                  ),
                  validator: (v) {
                    final n = int.tryParse(v ?? '');
                    if (n == null || n < 1 || n > 100) return 'عمر غير صحيح';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('النوع', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _choiceChip(
                        selected: _gender == Gender.male,
                        label: 'ذكر 👦',
                        onTap: () => setState(() => _gender = Gender.male),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _choiceChip(
                        selected: _gender == Gender.female,
                        label: 'أنثى 👧',
                        onTap: () => setState(() => _gender = Gender.female),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('نوع السكري', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _choiceChip(
                        selected: _type == DiabetesType.type1,
                        label: 'النوع الأول',
                        onTap: () => setState(() => _type = DiabetesType.type1),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _choiceChip(
                        selected: _type == DiabetesType.type2,
                        label: 'النوع الثاني',
                        onTap: () => setState(() => _type = DiabetesType.type2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ratioCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'معامل الكارب (جرام / وحدة أنسولين)',
                    helperText: 'مثال: 10 يعني كل 10 جرام كارب = وحدة أنسولين',
                    prefixIcon: Icon(Icons.science_outlined),
                  ),
                  validator: (v) {
                    final n = double.tryParse(v ?? '');
                    if (n == null || n <= 0) return 'أدخل معامل صحيح';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.alarm, color: AppColors.skyDark),
                  title: const Text('موعد الأنسولين القاعدي'),
                  subtitle: Text(_basal.format(context)),
                  trailing: TextButton(
                    onPressed: _pickBasal,
                    child: const Text('تغيير'),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _submit,
                  child: const Text('ابدأ الرحلة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _choiceChip({
    required bool selected,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.skyLight : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.skyDark : Colors.grey.shade300,
            width: selected ? 1.6 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.skyDark : AppColors.text,
          ),
        ),
      ),
    );
  }

  Future<void> _pickBasal() async {
    final picked = await showTimePicker(context: context, initialTime: _basal);
    if (picked != null) setState(() => _basal = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final profile = ChildProfile(
      name: _nameCtrl.text.trim(),
      age: int.parse(_ageCtrl.text.trim()),
      gender: _gender,
      diabetesType: _type,
      carbRatio: double.parse(_ratioCtrl.text.trim()),
      basalTime:
          '${_basal.hour.toString().padLeft(2, '0')}:${_basal.minute.toString().padLeft(2, '0')}',
    );
    await context.read<AppState>().completeOnboarding(profile);
  }
}
