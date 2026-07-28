import '../../../../core/services/api_service.dart';
import '../../../../core/utils/constants.dart';
import '../models/wallet_model.dart';

class WalletRepository {
  WalletRepository(this._api);

  final ApiService _api;

  Future<WalletModel> fetchWallet() async {
    final response = await _api.get(ApiEndpoints.wallet);
    return WalletModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> recharge({required String packageId}) async {
    // In production: obtain the platform purchase receipt (Play Billing /
    // Apple IAP) first, then send it here for server-side verification.
    await _api.post(ApiEndpoints.recharge, data: {'packageId': packageId});
  }

  Future<void> requestWithdrawal({required int diamonds}) async {
    await _api.post(ApiEndpoints.withdraw, data: {'diamonds': diamonds});
  }
}
