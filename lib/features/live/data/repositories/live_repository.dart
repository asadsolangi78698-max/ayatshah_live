import '../../../../core/services/api_service.dart';
import '../../../../core/utils/constants.dart';
import '../models/live_room_model.dart';

class LiveRepository {
  LiveRepository(this._api);

  final ApiService _api;

  Future<List<LiveRoomModel>> fetchLiveRooms({int page = 1}) async {
    final response = await _api.get(
      ApiEndpoints.liveList,
      query: {'page': page, 'pageSize': AppConstants.defaultPageSize},
    );
    final list = response.data['items'] as List<dynamic>? ?? [];
    return list
        .map((e) => LiveRoomModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Starts a broadcast; returns the Agora/ZEGO channel token + room id.
  Future<Map<String, dynamic>> startLive({required String title}) async {
    final response = await _api.post(ApiEndpoints.liveStart, data: {'title': title});
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> joinLive(String roomId) async {
    final response = await _api.post('${ApiEndpoints.liveJoin}/$roomId');
    return response.data as Map<String, dynamic>;
  }

  Future<void> endLive(String roomId) async {
    await _api.post('${ApiEndpoints.liveEnd}/$roomId');
  }
}
