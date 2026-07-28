import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/core_providers.dart';
import '../data/models/live_room_model.dart';
import '../data/repositories/live_repository.dart';

final liveRepositoryProvider = Provider<LiveRepository>((ref) {
  final api = ref.watch(apiServiceProvider);
  return LiveRepository(api);
});

/// Auto-disposing list of currently live rooms for the discover feed.
final liveRoomsProvider =
    FutureProvider.autoDispose<List<LiveRoomModel>>((ref) async {
  final repo = ref.watch(liveRepositoryProvider);
  return repo.fetchLiveRooms();
});
