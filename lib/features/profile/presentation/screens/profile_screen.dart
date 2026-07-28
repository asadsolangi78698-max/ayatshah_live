import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.primary,
                  backgroundImage:
                      user?.avatarUrl != null ? NetworkImage(user!.avatarUrl!) : null,
                  child: user?.avatarUrl == null
                      ? const Icon(Icons.person, size: 44, color: Colors.white)
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(user?.name ?? 'Unnamed User',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    if (user?.isVerified == true) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, size: 16, color: AppColors.primaryLight),
                    ],
                    if (user?.isVip == true) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.workspace_premium, size: 16, color: AppColors.accentGold),
                    ],
                  ],
                ),
                if (user?.bio != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(user!.bio!,
                        style: const TextStyle(color: AppColors.textSecondary)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatColumn(label: 'Followers', value: user?.followersCount ?? 0),
              _StatColumn(label: 'Following', value: user?.followingCount ?? 0),
              _StatColumn(label: 'Diamonds', value: user?.diamonds ?? 0),
            ],
          ),
          const SizedBox(height: 24),
          _ProfileMenuTile(icon: Icons.edit_outlined, label: 'Edit Profile', onTap: () {}),
          _ProfileMenuTile(icon: Icons.account_balance_wallet_outlined, label: 'Wallet', onTap: () {}),
          _ProfileMenuTile(icon: Icons.video_library_outlined, label: 'My Videos', onTap: () {}),
          _ProfileMenuTile(icon: Icons.shield_outlined, label: 'Blocked Users', onTap: () {}),
          _ProfileMenuTile(icon: Icons.help_outline, label: 'Help & Support', onTap: () {}),
          _ProfileMenuTile(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () => ref.read(authProvider.notifier).logout(),
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$value', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
      ],
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
      onTap: onTap,
    );
  }
}
