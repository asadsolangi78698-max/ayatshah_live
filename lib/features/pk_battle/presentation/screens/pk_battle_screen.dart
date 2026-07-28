import 'package:flutter/material.dart';
import '../../data/models/pk_battle_model.dart';
import '../widgets/pk_score_bar.dart';

class PkBattleScreen extends StatelessWidget {
  const PkBattleScreen({super.key, required this.battleId});

  final String battleId;

  @override
  Widget build(BuildContext context) {
    // Placeholder battle state — replace with a live-updating provider
    // fed by the socket channel for this battleId.
    const battle = PkBattleModel(
      id: 'demo',
      hostAId: 'a',
      hostBId: 'b',
      hostAName: 'Host A',
      hostBName: 'Host B',
      scoreA: 320,
      scoreB: 210,
      remainingSeconds: 96,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Row(
            children: const [
              Expanded(child: ColoredBox(color: Color(0xFF2A0F1A))),
              Expanded(child: ColoredBox(color: Color(0xFF0F1A2A))),
            ],
          ),
          Positioned(
            top: 56,
            left: 16,
            right: 16,
            child: const PkScoreBar(battle: battle),
          ),
          Positioned(
            top: 48,
            right: 12,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
        ],
      ),
    );
  }
}
