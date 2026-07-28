import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/responsive.dart';
import '../../../live/providers/live_provider.dart';
import '../../../live/presentation/widgets/live_room_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveRoomsAsync = ref.watch(liveRoomsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AyatShah Live'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(liveRoomsProvider.future),
        child: liveRoomsAsync.when(
          data: (rooms) {
            if (rooms.isEmpty) {
              return const Center(child: Text('No live rooms right now'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.gridColumns(context),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return LiveRoomCard(
                  room: room,
                  onTap: () => context.push('/live/${room.id}'),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Failed to load: $error')),
        ),
      ),
    );
  }
}
