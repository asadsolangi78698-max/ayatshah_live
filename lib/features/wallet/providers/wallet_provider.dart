import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/core_providers.dart';
import '../data/models/wallet_model.dart';
import '../data/repositories/wallet_repository.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  final api = ref.watch(apiServiceProvider);
  return WalletRepository(api);
});

final walletProvider = FutureProvider.autoDispose<WalletModel>((ref) async {
  final repo = ref.watch(walletRepositoryProvider);
  return repo.fetchWallet();
});

/// Static coin packages — swap for a server-driven list once available.
final coinPackagesProvider = Provider<List<CoinPackageModel>>((ref) => const [
      CoinPackageModel(id: 'coins_100', coins: 100, priceUsd: 0.99),
      CoinPackageModel(id: 'coins_500', coins: 500, priceUsd: 4.99, bonusCoins: 25),
      CoinPackageModel(id: 'coins_1000', coins: 1000, priceUsd: 9.99, bonusCoins: 75),
      CoinPackageModel(id: 'coins_5000', coins: 5000, priceUsd: 49.99, bonusCoins: 500),
    ]);
