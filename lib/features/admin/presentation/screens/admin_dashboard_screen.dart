import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';

/// Entry point for the web admin panel. Intended to run as a Flutter Web
/// build served separately from the mobile app (same codebase, same theme).
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(title: const Text('AyatShah Live — Admin')),
      body: Row(
        children: [
          if (isDesktop) const _AdminSideNav(),
          const Expanded(child: _AdminOverview()),
        ],
      ),
    );
  }
}

class _AdminSideNav extends StatelessWidget {
  const _AdminSideNav();

  static const _items = [
    ('Dashboard', Icons.dashboard_outlined),
    ('Users', Icons.people_outline),
    ('Hosts', Icons.star_outline),
    ('Agencies', Icons.apartment_outlined),
    ('Gifts', Icons.card_giftcard_outlined),
    ('Coins', Icons.monetization_on_outlined),
    ('Withdrawals', Icons.account_balance_outlined),
    ('Reports', Icons.flag_outlined),
    ('Live Monitoring', Icons.visibility_outlined),
    ('Analytics', Icons.bar_chart_outlined),
    ('Notifications', Icons.notifications_outlined),
    ('Ads', Icons.ads_click_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColors.surfaceDark,
      child: ListView(
        children: _items
            .map((item) => ListTile(
                  leading: Icon(item.$2, color: AppColors.textSecondary),
                  title: Text(item.$1, style: const TextStyle(fontSize: 13)),
                  onTap: () {},
                ))
            .toList(),
      ),
    );
  }
}

class _AdminOverview extends StatelessWidget {
  const _AdminOverview();

  @override
  Widget build(BuildContext context) {
    final cards = const [
      ('Total Users', '128,430', Icons.people),
      ('Active Lives', '342', Icons.live_tv),
      ('Pending Withdrawals', '18', Icons.pending_actions),
      ('Reports Today', '7', Icons.flag),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: cards
            .map((c) => Container(
                  width: 220,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardDark,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(c.$3, color: AppColors.primaryLight),
                      const SizedBox(height: 10),
                      Text(c.$2,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(c.$1, style: const TextStyle(color: AppColors.textMuted)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
