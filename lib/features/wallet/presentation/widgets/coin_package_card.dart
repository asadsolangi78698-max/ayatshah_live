import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/wallet_model.dart';

class CoinPackageCard extends StatelessWidget {
  const CoinPackageCard({super.key, required this.package, required this.onTap});

  final CoinPackageModel package;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.monetization_on, color: AppColors.accentGold, size: 20),
                  const SizedBox(width: 6),
                  Text('${package.coins}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              if (package.bonusCoins > 0)
                Text('+${package.bonusCoins} bonus',
                    style: const TextStyle(color: AppColors.success, fontSize: 11)),
              const Spacer(),
              Text('\$${package.priceUsd.toStringAsFixed(2)}',
                  style: const TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}
