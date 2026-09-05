import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';

class InjectionSite {
  const InjectionSite({
    required this.emoji,
    required this.title,
    required this.hint,
    required this.color,
  });

  final String emoji;
  final String title;
  final String hint;
  final Color color;
}

class InjectionSitesScreen extends StatelessWidget {
  const InjectionSitesScreen({super.key});

  static const sites = [
    InjectionSite(
      emoji: '🍔',
      title: 'البطن',
      hint: 'جنب الصرة شوية — مش فوق العضم. سهل وسريع قبل الأكل.',
      color: AppColors.orangeSoft,
    ),
    InjectionSite(
      emoji: '💪',
      title: 'الذراع',
      hint: 'الجزء الخارجي اللحيم من العضد. مناسب لو حد بيساعد الطفل.',
      color: AppColors.skyLight,
    ),
    InjectionSite(
      emoji: '🦵',
      title: 'الفخذ',
      hint: 'مقدمة الفخذ من بره. كويس الصبح أو قبل الرياضة الخفيفة.',
      color: AppColors.greenSoft,
    ),
    InjectionSite(
      emoji: '🍑',
      title: 'الردف',
      hint: 'الجزء العلوي الخارجي. استخدمه لما باقي الأماكن تحتاج راحة.',
      color: AppColors.yellowSoft,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أماكن الحقن')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            color: AppColors.skyLight,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🦸 دور البطل: دوّر المكان!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'مش بنحقن في نفس النقطة كل يوم. نختار منطقة، ونتحرك شوية جواها، وبعدين نبدّل المنطقة عشان الجلد يفضل مرتاح.',
                  style: TextStyle(height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const SectionTitle('٤ مناطق بس — سهلة تتذكرها'),
          const SizedBox(height: 10),
          ...sites.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SoftCard(
                color: s.color,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.emoji, style: const TextStyle(fontSize: 36)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(s.hint, style: const TextStyle(height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SectionTitle('قواعد ذهبية'),
                SizedBox(height: 8),
                _Bullet('بدّل المكان كل حقنة (حتى لو نفس المنطقة).'),
                _Bullet('سيّب مسافة إصبع تقريبًا عن آخر نقطة.'),
                _Bullet('متحقنش فوق كدمة أو جلد متورم أو ندبة.'),
                _Bullet('لو الألم أو الانتفاخ زاد: كلّم الدكتور.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SoftCard(
            color: AppColors.orangeSoft,
            child: Text(
              'دي ملخص لطيف للأهل والطفل — مش بديل لتعليمات فريق السكري بتاعكم.',
              style: TextStyle(height: 1.4, color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⭐ ', style: TextStyle(fontSize: 14)),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
        ],
      ),
    );
  }
}
