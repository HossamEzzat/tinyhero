import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';

class _Poster {
  const _Poster({
    required this.asset,
    required this.chip,
    required this.title,
    required this.blurb,
  });

  final String asset;
  final String chip;
  final String title;
  final String blurb;
}

class _Rule {
  const _Rule(this.emoji, this.title, this.body);

  final String emoji;
  final String title;
  final String body;
}

class InjectionSitesScreen extends StatefulWidget {
  const InjectionSitesScreen({super.key});

  @override
  State<InjectionSitesScreen> createState() => _InjectionSitesScreenState();
}

class _InjectionSitesScreenState extends State<InjectionSitesScreen> {
  static const _posters = [
    _Poster(
      asset: 'assets/images/injection/sites_overview.jpg',
      chip: 'المواضع',
      title: 'أربع مناطق بس',
      blurb:
          'البطن الأسرع امتصاصًا، وأعلى الذراع متوسط، والفخذ أبطأ، والأرداف الأبطأ. اختَر واحدة ودوّر بينها.',
    ),
    _Poster(
      asset: 'assets/images/injection/belly_zones.jpg',
      chip: 'جانبي البطن',
      title: 'يمين أو شمال',
      blurb:
          'المنطقة المثالية للأنسولين سريع المفعول قبل الوجبات: جانبي البطن، بعيدًا عن السرة بمقدار ٥ سم.',
    ),
    _Poster(
      asset: 'assets/images/injection/belly_5cm.jpg',
      chip: '٥ سم',
      title: 'قِس إصبعين',
      blurb:
          'من السرة لفوق أو للجنب حوالي ٥ سم (إصبعين). تقدر تحقن من أي جانب، وتبعد عن المنطقة القريبة من السرة.',
    ),
    _Poster(
      asset: 'assets/images/injection/belly_avoid.jpg',
      chip: 'بعيد عن السرة',
      title: 'متحقنش حوالين السرة',
      blurb:
          'السرة نفسها والدايرة اللي حواليها ممنوعة. المكان الآمن هو المربعين على الجانبين.',
    ),
  ];

  static const _rules = [
    _Rule(
      '🔁',
      'دوّر أماكن الحقن',
      'لا تحقن في نفس البقعة مرتين متتاليتين. اترك مسافة ٢–٤ سم بين الحقنة والسابقة، عشان تتجنب تكتل الدهون اللي يمنع امتصاص الأنسولين.',
    ),
    _Rule(
      '🚫',
      'تجنب العيوب',
      'ابتعد تمامًا عن الشامات، الندبات، علامات التمدد، أو أي منطقة تحس فيها بصلابة أو كتل.',
    ),
    _Rule('📐', 'الزاوية القائمة', 'احقن بزاوية ٩٠ درجة عمودية على الجلد.'),
    _Rule(
      '⏱️',
      'قاعدة الـ ١٠ ثوانٍ',
      'بعد الضغط على مكبس القلم بالكامل، انتظر ١٠ ثوانٍ قبل سحب الإبرة لمنع تسريب الأنسولين.',
    ),
  ];

  late final PageController _pages;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pages = PageController(viewportFraction: 0.86);
  }

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    _pages.animateToPage(
      index,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _openGallery(int index) async {
    final next = await Navigator.of(context).push<int>(
      PageRouteBuilder<int>(
        transitionDuration: const Duration(milliseconds: 280),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, _, _) => _PosterGallery(initialIndex: index),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
    if (!mounted || next == null) return;
    _pages.jumpToPage(next);
    setState(() => _index = next);
  }

  @override
  Widget build(BuildContext context) {
    final poster = _posters[_index];
    final carouselHeight = (MediaQuery.sizeOf(context).width * 0.86).clamp(
      280.0,
      460.0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('أماكن الحقن')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 28),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SoftCard(
              color: AppColors.skyLight,
              child: Text(
                'اسحب الصورة عشان تشوف كل موضع، أو اضغطها للتكبير.',
                style: TextStyle(height: 1.45, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _posters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final selected = i == _index;
                return GestureDetector(
                  onTap: () => _goTo(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.skyDark : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected
                            ? AppColors.skyDark
                            : const Color(0xFFD6EAF8),
                      ),
                    ),
                    child: Text(
                      _posters[i].chip,
                      style: TextStyle(
                        color: selected ? Colors.white : AppColors.skyDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: carouselHeight,
            child: PageView.builder(
              controller: _pages,
              itemCount: _posters.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, i) {
                return AnimatedBuilder(
                  animation: _pages,
                  builder: (context, child) {
                    var delta = 0.0;
                    if (_pages.hasClients && _pages.position.haveDimensions) {
                      delta = ((_pages.page ?? _index.toDouble()) - i)
                          .abs()
                          .clamp(0.0, 1.0);
                    }
                    final scale = 1 - (delta * 0.07);
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 10,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.skyDark.withValues(alpha: 0.16),
                            blurRadius: 22,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Material(
                        color: const Color(0xFFEAF6FD),
                        borderRadius: BorderRadius.circular(28),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => _openGallery(i),
                          child: Image.asset(
                            _posters[i].asset,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_posters.length, (i) {
              final selected = i == _index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOut,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 7,
                width: selected ? 22 : 7,
                decoration: BoxDecoration(
                  color: selected ? AppColors.skyDark : const Color(0xFFB3E5FC),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: Column(
                key: ValueKey(_index),
                children: [
                  Text(
                    poster.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    poster.blurb,
                    textAlign: TextAlign.center,
                    style: const TextStyle(height: 1.5, color: AppColors.text),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SectionTitle('القواعد الذهبية الأربع'),
          ),
          const SizedBox(height: 10),
          ..._rules.map(
            (rule) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: SoftCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rule.emoji, style: const TextStyle(fontSize: 26)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rule.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(rule.body, style: const TextStyle(height: 1.45)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SoftCard(
              color: AppColors.orangeSoft,
              child: Text(
                'دي ملخص لطيف للأهل والطفل — مش بديل لتعليمات فريق السكري بتاعكم.',
                style: TextStyle(height: 1.4, color: AppColors.textMuted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PosterGallery extends StatefulWidget {
  const _PosterGallery({required this.initialIndex});

  final int initialIndex;

  @override
  State<_PosterGallery> createState() => _PosterGalleryState();
}

class _PosterGalleryState extends State<_PosterGallery> {
  late final PageController _pages;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _pages = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posters = _InjectionSitesScreenState._posters;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        Navigator.of(context).pop(_index);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF102027),
        appBar: AppBar(
          backgroundColor: const Color(0xFF102027),
          foregroundColor: Colors.white,
          title: Text(posters[_index].title),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(_index),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pages,
                itemCount: posters.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  return InteractiveViewer(
                    minScale: 1,
                    maxScale: 4,
                    child: Center(
                      child: Image.asset(posters[i].asset, fit: BoxFit.contain),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
              child: Text(
                posters[_index].blurb,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, height: 1.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
