import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/audio_room_model.dart';
import '../widgets/mic_seat_widget.dart';

class AudioRoomScreen extends StatefulWidget {
  const AudioRoomScreen({super.key, required this.roomId});

  final String roomId;

  @override
  State<AudioRoomScreen> createState() => _AudioRoomScreenState();
}

class _AudioRoomScreenState extends State<AudioRoomScreen> {
  // Placeholder seat data — replace with a Riverpod provider backed by
  // a websocket/room-state stream once the backend room events are wired up.
  late final List<MicSeatModel> _seats = List.generate(
    10,
    (i) => MicSeatModel(seatIndex: i),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friday Night Chill 🎙️'),
        actions: [
          IconButton(icon: const Icon(Icons.people_outline), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.campaign_outlined, size: 16, color: AppColors.textMuted),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Welcome! Be respectful and have fun 🎉',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemCount: _seats.length,
              itemBuilder: (context, index) {
                final seat = _seats[index];
                return MicSeatWidget(
                  seat: seat,
                  onTap: () {
                    // TODO: request seat / open host controls (lock, mute, kick).
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Send a message...',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.music_note_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
