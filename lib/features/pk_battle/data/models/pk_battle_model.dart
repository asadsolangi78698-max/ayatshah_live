class PkBattleModel {
  const PkBattleModel({
    required this.id,
    required this.hostAId,
    required this.hostBId,
    required this.hostAName,
    required this.hostBName,
    this.scoreA = 0,
    this.scoreB = 0,
    this.remainingSeconds = 180,
    this.isTeamBattle = false,
  });

  final String id;
  final String hostAId;
  final String hostBId;
  final String hostAName;
  final String hostBName;
  final int scoreA;
  final int scoreB;
  final int remainingSeconds;
  final bool isTeamBattle;

  double get progressA {
    final total = scoreA + scoreB;
    if (total == 0) return 0.5;
    return scoreA / total;
  }

  factory PkBattleModel.fromJson(Map<String, dynamic> json) => PkBattleModel(
        id: json['id'] as String,
        hostAId: json['hostAId'] as String,
        hostBId: json['hostBId'] as String,
        hostAName: json['hostAName'] as String? ?? '',
        hostBName: json['hostBName'] as String? ?? '',
        scoreA: json['scoreA'] as int? ?? 0,
        scoreB: json['scoreB'] as int? ?? 0,
        remainingSeconds: json['remainingSeconds'] as int? ?? 180,
        isTeamBattle: json['isTeamBattle'] as bool? ?? false,
      );
}
