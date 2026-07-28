class WalletModel {
  const WalletModel({
    required this.coinBalance,
    required this.diamondBalance,
    this.totalEarnings = 0,
  });

  final int coinBalance;
  final int diamondBalance;
  final int totalEarnings;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        coinBalance: json['coinBalance'] as int? ?? 0,
        diamondBalance: json['diamondBalance'] as int? ?? 0,
        totalEarnings: json['totalEarnings'] as int? ?? 0,
      );
}

class CoinPackageModel {
  const CoinPackageModel({
    required this.id,
    required this.coins,
    required this.priceUsd,
    this.bonusCoins = 0,
  });

  final String id;
  final int coins;
  final double priceUsd;
  final int bonusCoins;
}
