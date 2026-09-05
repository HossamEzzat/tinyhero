import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';

class EmergencyGuidesScreen extends StatelessWidget {
  const EmergencyGuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ماذا أفعل؟')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            color: AppColors.yellowSoft,
            onTap: () => _open(
              context,
              title: 'هبوط السكر',
              color: AppColors.yellowSoft,
              accent: const Color(0xFFF9A825),
              symptoms: const [
                'دوخة أو رعشة',
                'تعرق',
                'جوع شديد',
                'صداع أو اهتياج',
                'ضعف أو تشوش',
              ],
              steps: const [
                'خذ حوالي 15 جرام كارب سريع (عصير، سكر، أقراص جلوكوز).',
                'انتظر ربع ساعة ثم قِس السكر مرة أخرى.',
                'لو لسه في هبوط: أعد نفس الخطوة.',
                'بعد التحسن: ثبّت بمصدر فيه ألياف/بروتين + كارب معقد (مثال: لقمة عيش وجبنة).',
              ],
            ),
            child: const _GuideHeader(
              emoji: '⬇️',
              title: 'عند هبوط السكر (تحت 80)',
              subtitle: 'أعراض + خطة الـ 15 جرام',
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            color: AppColors.redSoft,
            onTap: () => _open(
              context,
              title: 'ارتفاع السكر',
              color: AppColors.redSoft,
              accent: AppColors.red,
              symptoms: const [
                'عطش شديد',
                'كثرة التبول',
                'إرهاق',
                'صداع',
                'جفاف أو ضبابية رؤية',
              ],
              steps: const [
                'اشرب ماء بكمية كافية.',
                'تحقق من الكيتونات إذا نصح الطبيب بذلك.',
                'راجع جرعة التصحيح حسب خطة الطبيب فقط.',
                'لو في قيء/ألم بطن/نعاس شديد: توجّه للطوارئ فورًا.',
              ],
            ),
            child: const _GuideHeader(
              emoji: '⬆️',
              title: 'عند ارتفاع السكر (من 180)',
              subtitle: 'أعراض + خطوات أمان',
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            color: AppColors.orangeSoft,
            onTap: () => _open(
              context,
              title: 'ذبذبة السكر',
              color: AppColors.orangeSoft,
              accent: AppColors.orange,
              symptoms: const [
                'صعود وهبوط سريع خلال ساعات قليلة',
                'دوخة أو تعب مفاجئ',
                'صعوبة تركيز أو تهيّج',
                'خوف أو قلق بعد الأكل/الرياضة',
              ],
              steps: const [
                'قيس السكر بدل ما تعتمد على الإحساس بس.',
                'سجّل الأكل والرياضة والجرعات عشان تشوف النمط.',
                'بعد الأكل السكري أو المجهود: راقب أكتر أول ساعتين.',
                'لو الذبذبة متكررة: راجع الخطة مع فريق السكري.',
              ],
            ),
            child: const _GuideHeader(
              emoji: '〰️',
              title: 'ذبذبة السكر (صعود ونزول)',
              subtitle: 'أعراض + إزاي نقلل الخطر',
            ),
          ),
          const SizedBox(height: 12),
          const SoftCard(
            child: Text(
              'هذه إرشادات عامة للأهل والطفل وليست بديلاً عن تعليمات الطبيب.',
              style: TextStyle(color: AppColors.textMuted, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  void _open(
    BuildContext context, {
    required String title,
    required Color color,
    required Color accent,
    required List<String> symptoms,
    required List<String> steps,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _GuideDetail(
          title: title,
          color: color,
          accent: accent,
          symptoms: symptoms,
          steps: steps,
        ),
      ),
    );
  }
}

class _GuideHeader extends StatelessWidget {
  const _GuideHeader({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  final String emoji;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 36)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subtitle, style: const TextStyle(color: AppColors.textMuted)),
            ],
          ),
        ),
        const Icon(Icons.chevron_left),
      ],
    );
  }
}

class _GuideDetail extends StatelessWidget {
  const _GuideDetail({
    required this.title,
    required this.color,
    required this.accent,
    required this.symptoms,
    required this.steps,
  });

  final String title;
  final Color color;
  final Color accent;
  final List<String> symptoms;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: accent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            color: color,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('الأعراض'),
                const SizedBox(height: 8),
                ...symptoms.map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 8, color: accent),
                        const SizedBox(width: 8),
                        Expanded(child: Text(s)),
                      ],
                    ),
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
                const SectionTitle('الخطوات'),
                const SizedBox(height: 8),
                ...steps.asMap().entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: accent,
                          child: Text(
                            '${e.key + 1}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(e.value, style: const TextStyle(height: 1.4))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
