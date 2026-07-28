import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/pk_battle_model.dart';

class PkScoreBar extends StatelessWidget {
  const PkScoreBar({super.key, required this.battle});

  final PkBattleModel battle;

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timer_outlined, size: 14, color: Colors.white),
              const SizedBox(width: 4),
              Text(_formatTime(battle.remainingSeconds),
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 14,
            child: Row(
              children: [
                Expanded(
                  flex: (battle.progressA * 1000).round().clamp(1, 999),
                  child: Container(decoration: const BoxDecoration(gradient: AppColors.pkTeamAGradient)),
                ),
                Expanded(
                  flex: ((1 - battle.progressA) * 1000).round().clamp(1, 999),
                  child: Container(decoration: const BoxDecoration(gradient: AppColors.pkTeamBGradient)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${battle.hostAName}  ${battle.scoreA}',
                style: const TextStyle(color: Colors.white, fontSize: 11)),
            Text('${battle.scoreB}  ${battle.hostBName}',
                style: const TextStyle(color: Colors.white, fontSize: 11)),
          ],
        ),
      ],
    );
  }
}
