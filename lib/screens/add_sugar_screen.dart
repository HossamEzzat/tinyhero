import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/food_database.dart';
import '../models/models.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class AddSugarScreen extends StatefulWidget {
  const AddSugarScreen({super.key});

  @override
  State<AddSugarScreen> createState() => _AddSugarScreenState();
}

class _AddSugarScreenState extends State<AddSugarScreen> {
  final _valueCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  DateTime _at = DateTime.now();
  int? _mood;

  @override
  void dispose() {
    _valueCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  SugarStatus? get _previewStatus {
    final v = double.tryParse(_valueCtrl.text);
    if (v == null) return null;
    if (v < 80) return SugarStatus.low;
    if (v >= 180) return SugarStatus.high;
    return SugarStatus.normal;
  }

  @override
  Widget build(BuildContext context) {
    final status = _previewStatus;
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة قياس سكر')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            color: switch (status) {
              SugarStatus.low => AppColors.yellowSoft,
              SugarStatus.high => AppColors.redSoft,
              SugarStatus.normal => AppColors.greenSoft,
              null => AppColors.card,
            },
            child: Column(
              children: [
                Text(
                  _valueCtrl.text.isEmpty ? '—' : _valueCtrl.text,
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: switch (status) {
                      SugarStatus.low => const Color(0xFFF9A825),
                      SugarStatus.high => AppColors.red,
                      SugarStatus.normal => AppColors.green,
                      null => AppColors.text,
                    },
                  ),
                ),
                const Text('mg/dL'),
                if (status != null)
                  Text(
                    '${SugarHelpers.statusLabel(status)} ${SugarHelpers.statusEmoji(status)}',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                const SizedBox(height: 4),
                const Text(
                  'هبوط تحت 80 · طبيعي · مرتفع من 180',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valueCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'قيمة السكر',
              prefixIcon: Icon(Icons.bloodtype_outlined),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.access_time, color: AppColors.skyDark),
            title: const Text('التاريخ والوقت'),
            subtitle: Text(_format(_at)),
            trailing: TextButton(onPressed: _pickDateTime, child: const Text('تغيير')),
          ),
          TextField(
            controller: _noteCtrl,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'ملاحظة (اختياري)',
              prefixIcon: Icon(Icons.notes),
            ),
          ),
          const SizedBox(height: 16),
          const Text('كيف تشعر؟', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final e in const [
                (0, '😊'),
                (1, '😐'),
                (2, '😟'),
                (3, '🤒'),
              ])
                GestureDetector(
                  onTap: () => setState(() => _mood = e.$1),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _mood == e.$1 ? AppColors.skyLight : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _mood == e.$1 ? AppColors.skyDark : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(e.$2, style: const TextStyle(fontSize: 28)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: _save, child: const Text('حفظ القياس')),
        ],
      ),
    );
  }

  String _format(DateTime d) =>
      '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}  '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _at,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_at),
    );
    if (time == null) return;
    setState(() {
      _at = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future<void> _save() async {
    final value = double.tryParse(_valueCtrl.text.trim());
    if (value == null || value <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل قيمة سكر صحيحة')),
      );
      return;
    }
    final state = context.read<AppState>();
    await state.addReading(
      SugarReading(
        id: state.newId(),
        value: value,
        at: _at,
        note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        mood: _mood,
      ),
    );
    if (!mounted) return;
    Navigator.pop(context);
  }
}
