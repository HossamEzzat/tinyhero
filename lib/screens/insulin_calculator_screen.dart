import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/food_database.dart';
import '../models/models.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class _MealLine {
  FoodItem? food;
  final TextEditingController gramsCtrl;

  _MealLine({this.food, String grams = '100'})
      : gramsCtrl = TextEditingController(text: grams);

  double get grams => double.tryParse(gramsCtrl.text) ?? 0;
  double get carbs => (food?.carbPerGram ?? 0) * grams;

  void dispose() => gramsCtrl.dispose();
}

class InsulinCalculatorScreen extends StatefulWidget {
  const InsulinCalculatorScreen({super.key});

  @override
  State<InsulinCalculatorScreen> createState() => _InsulinCalculatorScreenState();
}

class _InsulinCalculatorScreenState extends State<InsulinCalculatorScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _manualCarbsCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  final List<_MealLine> _lines = [_MealLine()];
  bool _saveMeal = true;
  static const int _maxLines = 8;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _manualCarbsCtrl.dispose();
    _searchCtrl.dispose();
    for (final line in _lines) {
      line.dispose();
    }
    super.dispose();
  }

  double get _totalCarbs => _lines.fold(0.0, (sum, l) => sum + l.carbs);

  bool get _canSave =>
      _lines.any((l) => l.food != null && l.grams > 0);

  @override
  Widget build(BuildContext context) {
    final ratio = context.watch<AppState>().profile?.carbRatio ?? 10;

    return Scaffold(
      appBar: AppBar(
        title: const Text('حاسبة الأنسولين'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'وجبة كاملة'),
            Tab(text: 'كارب يدوي'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _mealTab(ratio),
          _manualTab(ratio),
        ],
      ),
    );
  }

  Widget _mealTab(double ratio) {
    final units = InsulinCalculator.unitsFromTotalCarbs(_totalCarbs, ratio);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SoftCard(
          child: TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              labelText: 'ابحث عن الأكل',
              hintText: 'مثال: أرز، تفاح، عيش…',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchCtrl.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchCtrl.clear();
                        setState(() {});
                      },
                    ),
            ),
            onChanged: (_) => setState(() {}),
            onTap: () => _openFoodPicker(forLineIndex: null),
            readOnly: true,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'أضف أصناف الوجبة (حتى $_maxLines) واكتب الوزن لكل صنف',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 12),
        ..._lines.asMap().entries.map((e) => _lineCard(e.key, e.value)),
        if (_lines.length < _maxLines)
          OutlinedButton.icon(
            onPressed: () => setState(() => _lines.add(_MealLine())),
            icon: const Icon(Icons.add),
            label: const Text('إضافة صنف آخر'),
          ),
        const SizedBox(height: 12),
        _resultCard(
          totalCarbs: _totalCarbs,
          ratio: ratio,
          units: units,
          detail: _filledCountLabel(),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          value: _saveMeal,
          onChanged: (v) => setState(() => _saveMeal = v),
          title: const Text('حفظ كوجبة'),
          contentPadding: EdgeInsets.zero,
        ),
        FilledButton(
          onPressed: !_canSave
              ? null
              : () => _saveMealLines(_totalCarbs, units, ratio),
          child: const Text('اعتماد الحسبة'),
        ),
      ],
    );
  }

  String? _filledCountLabel() {
    final count = _lines.where((l) => l.food != null && l.grams > 0).length;
    if (count == 0) return null;
    return '$count صنف في الوجبة';
  }

  Widget _lineCard(int index, _MealLine line) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.skyLight,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.skyDark,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'صنف ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                if (_lines.length > 1)
                  IconButton(
                    tooltip: 'حذف',
                    onPressed: () {
                      setState(() {
                        line.dispose();
                        _lines.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete_outline, color: AppColors.red),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _openFoodPicker(forLineIndex: index),
              borderRadius: BorderRadius.circular(14),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'الصنف',
                  prefixIcon: Icon(Icons.restaurant),
                ),
                child: Text(
                  line.food == null
                      ? 'اضغط للاختيار أو البحث…'
                      : '${line.food!.name}  (${FoodDatabase.carbLabel(line.food!)})',
                  style: TextStyle(
                    color: line.food == null
                        ? AppColors.textMuted
                        : AppColors.text,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: line.gramsCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'الوزن (جرام)',
                prefixIcon: Icon(Icons.scale),
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (line.food != null && line.grams > 0) ...[
              const SizedBox(height: 8),
              Text(
                'كارب هذا الصنف: ${line.carbs.toStringAsFixed(1)} جرام',
                style: const TextStyle(
                  color: AppColors.skyDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _openFoodPicker({required int? forLineIndex}) async {
    final selected = await showModalBottomSheet<FoodItem>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _FoodPickerSheet(initialQuery: _searchCtrl.text),
    );
    if (selected == null || !mounted) return;

    setState(() {
      _searchCtrl.clear();
      if (forLineIndex != null) {
        _lines[forLineIndex].food = selected;
      } else {
        final empty = _lines.indexWhere((l) => l.food == null);
        if (empty >= 0) {
          _lines[empty].food = selected;
        } else if (_lines.length < _maxLines) {
          _lines.add(_MealLine(food: selected));
        } else {
          _lines.last.food = selected;
        }
      }
    });
  }

  Widget _manualTab(double ratio) {
    final carbs = double.tryParse(_manualCarbsCtrl.text) ?? 0;
    final units = InsulinCalculator.unitsFromTotalCarbs(carbs, ratio);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SoftCard(
          child: TextField(
            controller: _manualCarbsCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'إجمالي جرامات الكارب',
              helperText: 'أدخل الكارب الكلي، والقسمة تتم تلقائيًا على المعامل',
              prefixIcon: Icon(Icons.grain),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        const SizedBox(height: 12),
        _resultCard(totalCarbs: carbs, ratio: ratio, units: units),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: carbs <= 0
              ? null
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'اقتراح الجرعة: ${units.toStringAsFixed(1)} وحدة',
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
          child: const Text('تم'),
        ),
      ],
    );
  }

  Widget _resultCard({
    required double totalCarbs,
    required double ratio,
    required double units,
    String? detail,
  }) {
    return SoftCard(
      color: AppColors.skyLight,
      child: Column(
        children: [
          if (detail != null) ...[
            Text(detail, style: const TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: 6),
          ],
          Text(
            '${totalCarbs.toStringAsFixed(1)} ÷ ${ratio.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            '${units.toStringAsFixed(1)} وحدة أنسولين',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.skyDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'هذه قيمة إرشادية فقط — راجع الطبيب قبل الاعتماد عليها',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  Future<void> _saveMealLines(double totalCarbs, double units, double ratio) async {
    final state = context.read<AppState>();
    final now = DateTime.now();
    final filled = _lines.where((l) => l.food != null && l.grams > 0).toList();

    if (_saveMeal) {
      for (final line in filled) {
        final food = line.food!;
        final itemCarbs = line.carbs;
        final itemUnits = InsulinCalculator.unitsFromTotalCarbs(itemCarbs, ratio);
        await state.addMeal(
          MealEntry(
            id: state.newId(),
            foodName: food.name,
            category: food.category,
            carbPerGram: food.carbPerGram,
            grams: line.grams,
            at: now,
            insulinUnits: itemUnits,
          ),
        );
      }
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'إجمالي ${totalCarbs.toStringAsFixed(1)} كارب → ${units.toStringAsFixed(1)} وحدة',
        ),
      ),
    );
    Navigator.pop(context);
  }
}

class _FoodPickerSheet extends StatefulWidget {
  const _FoodPickerSheet({this.initialQuery = ''});

  final String initialQuery;

  @override
  State<_FoodPickerSheet> createState() => _FoodPickerSheetState();
}

class _FoodPickerSheetState extends State<_FoodPickerSheet> {
  late final TextEditingController _query;
  FoodCategory? _filter;

  @override
  void initState() {
    super.initState();
    _query = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  List<FoodItem> get _results {
    var list = FoodDatabase.search(_query.text);
    if (_filter != null) {
      list = list.where((f) => f.category == _filter).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    final height = MediaQuery.of(context).size.height * 0.85;

    return SizedBox(
      height: height,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'اختَر الأكل',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _query,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'بحث',
                hintText: 'اكتب اسم الأكل…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _query.clear();
                          setState(() {});
                        },
                      ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: FilterChip(
                      selected: _filter == null,
                      label: const Text('الكل'),
                      onSelected: (_) => setState(() => _filter = null),
                    ),
                  ),
                  ...FoodCategory.values.map(
                    (c) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: FilterChip(
                        selected: _filter == c,
                        label: Text(
                          '${FoodDatabase.categoryEmoji(c)} ${FoodDatabase.categoryLabel(c)}',
                        ),
                        onSelected: (_) => setState(() => _filter = c),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: results.isEmpty
                  ? const Center(child: Text('مفيش نتائج مطابقة'))
                  : ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (ctx, i) {
                        final f = results[i];
                        return ListTile(
                          leading: Text(
                            FoodDatabase.categoryEmoji(f.category),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(f.name),
                          subtitle: Text(FoodDatabase.categoryLabel(f.category)),
                          trailing: Text(
                            FoodDatabase.carbLabel(f),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.skyDark,
                            ),
                          ),
                          onTap: () => Navigator.pop(ctx, f),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
