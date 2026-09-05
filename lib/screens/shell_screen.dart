import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'meals_screen.dart';
import 'more_screen.dart';
import 'reminders_screen.dart';
import 'reports_screen.dart';
import 'add_sugar_screen.dart';
import 'insulin_calculator_screen.dart';
import 'emergency_guides_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        onQuickAdd: () => _open(const AddSugarScreen()),
        onQuickInsulin: () => _open(const InsulinCalculatorScreen()),
        onQuickMeals: () => setState(() => _index = 1),
        onQuickReports: () => setState(() => _index = 3),
        onEmergency: () => _open(const EmergencyGuidesScreen()),
      ),
      const MealsScreen(),
      const SizedBox.shrink(), // center + handled separately
      const ReportsScreen(),
      const MoreScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _index == 2 ? 0 : _index,
        children: [
          pages[0],
          pages[1],
          pages[0],
          pages[3],
          pages[4],
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 10,
        child: SizedBox(
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(0, Icons.home_rounded, 'الرئيسية'),
              _navItem(1, Icons.restaurant_menu_rounded, 'الوجبات'),
              const SizedBox(width: 48),
              _navItem(3, Icons.bar_chart_rounded, 'التقارير'),
              _navItem(4, Icons.more_horiz_rounded, 'المزيد'),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.skyDark,
        onPressed: _showAddSheet,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _navItem(int i, IconData icon, String label) {
    final selected = _index == i;
    return InkWell(
      onTap: () => setState(() => _index = i),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? AppColors.skyDark : AppColors.textMuted),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: selected ? AppColors.skyDark : AppColors.textMuted,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'إضافة سريعة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.skyLight,
                  child: Icon(Icons.bloodtype, color: AppColors.skyDark),
                ),
                title: const Text('قياس سكر'),
                onTap: () {
                  Navigator.pop(ctx);
                  _open(const AddSugarScreen());
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.orangeSoft,
                  child: Icon(Icons.calculate, color: AppColors.orange),
                ),
                title: const Text('حاسبة الأنسولين'),
                onTap: () {
                  Navigator.pop(ctx);
                  _open(const InsulinCalculatorScreen());
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.greenSoft,
                  child: Icon(Icons.notifications_active, color: AppColors.green),
                ),
                title: const Text('المنبّه والتنبيهات'),
                onTap: () {
                  Navigator.pop(ctx);
                  _open(const RemindersScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _open(Widget page) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}
