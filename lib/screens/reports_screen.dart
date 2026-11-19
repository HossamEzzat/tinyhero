import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _rangeDays = 30;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final range = Duration(days: _rangeDays);
    final list = state.readingsInRange(range).reversed.toList();
    final avg = state.averageSugar(range);
    final low = list.where((r) => r.status == SugarStatus.low).length;
    final high = list.where((r) => r.status == SugarStatus.high).length;
    final normal = list.where((r) => r.status == SugarStatus.normal).length;
    final total = list.isEmpty ? 1 : list.length;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          children: [
            ScreenHeader(
              title: 'التقارير',
              subtitle: list.isEmpty
                  ? 'مفيش قراءات في الفترة دي'
                  : '${list.length} قراءة',
            ),
            Row(
              children: [
                _chip('شهر', 30),
                const SizedBox(width: 8),
                _chip('3 شهور', 90),
              ],
            ),
            const SizedBox(height: 14),
            SoftCard(
              child: Column(
                children: [
                  const Text(
                    'متوسط السكر',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                  Text(
                    avg == null ? '—' : avg.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.skyDark,
                    ),
                  ),
                  const Text('mg/dL'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SoftCard(
              child: SizedBox(
                height: 200,
                child: list.length < 2
                    ? const Center(
                        child: Text(
                          'أضف قياسين على الأقل لعرض المنحنى',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      )
                    : LineChart(
                        LineChartData(
                          minY: 40,
                          maxY: 350,
                          titlesData: FlTitlesData(
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                                interval: (list.length / 4)
                                    .clamp(1, 999)
                                    .toDouble(),
                                getTitlesWidget: (v, meta) {
                                  final i = v.toInt();
                                  if (i < 0 || i >= list.length) {
                                    return const SizedBox.shrink();
                                  }
                                  final d = list[i].at;
                                  return Text(
                                    '${d.day}/${d.month}',
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(
                            show: true,
                            drawVerticalLine: false,
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                for (var i = 0; i < list.length; i++)
                                  FlSpot(i.toDouble(), list[i].value),
                              ],
                              isCurved: true,
                              color: AppColors.skyDark,
                              barWidth: 3,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: AppColors.sky.withValues(alpha: 0.2),
                              ),
                            ),
                          ],
                          extraLinesData: ExtraLinesData(
                            horizontalLines: [
                              HorizontalLine(
                                y: 80,
                                color: AppColors.yellow,
                                strokeWidth: 1,
                              ),
                              HorizontalLine(
                                y: 180,
                                color: AppColors.red,
                                strokeWidth: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            SoftCard(
              child: Column(
                children: [
                  const SectionTitle('توزيع القراءات'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: list.isEmpty
                        ? const Center(
                            child: Text(
                              'لا توجد بيانات',
                              style: TextStyle(color: AppColors.textMuted),
                            ),
                          )
                        : PieChart(
                            PieChartData(
                              sectionsSpace: 2,
                              centerSpaceRadius: 36,
                              sections: [
                                PieChartSectionData(
                                  value: normal.toDouble(),
                                  color: AppColors.green,
                                  title: '${((normal / total) * 100).round()}%',
                                  radius: 42,
                                  titleStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                PieChartSectionData(
                                  value: high.toDouble(),
                                  color: AppColors.red,
                                  title: '${((high / total) * 100).round()}%',
                                  radius: 42,
                                  titleStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                PieChartSectionData(
                                  value: low.toDouble(),
                                  color: AppColors.yellow,
                                  title: '${((low / total) * 100).round()}%',
                                  radius: 42,
                                  titleStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Legend(color: AppColors.green, label: 'طبيعي $normal'),
                      _Legend(color: AppColors.red, label: 'مرتفع $high'),
                      _Legend(
                        color: const Color(0xFFF9A825),
                        label: 'هبوط $low',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, int days) {
    final selected = _rangeDays == days;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _rangeDays = days),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
