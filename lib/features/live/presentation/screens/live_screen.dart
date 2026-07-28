import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../providers/live_provider.dart';

/// Live room screen. Video rendering is wired via Agora/ZEGO SDK —
/// see README's "Live Streaming SDK" section for the RtcEngine hookup.
class LiveScreen extends ConsumerStatefulWidget {
  const LiveScreen({super.key, required this.roomId});

  final String roomId;

  @override
  ConsumerState<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends ConsumerState<LiveScreen> {
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: ref.read(liveRepositoryProvider).joinLive(widget.roomId)
    // then initialize RtcEngine and join the Agora/ZEGO channel using
    // the token returned from that call.
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video surface placeholder — replace with AgoraVideoView / ZegoCanvas.
          const Positioned.fill(
            child: ColoredBox(color: Colors.black87),
          ),

          // Top bar: host info + close
          Positioned(
            top: 48,
            left: 12,
            right: 12,
            child: Row(
              children: [
                const CircleAvatar(backgroundColor: AppColors.primary, radius: 18),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Host Name', style: TextStyle(color: Colors.white)),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
          ),

          // Bottom: comments + actions
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Say something...',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: AppColors.accentPink),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.card_giftcard, color: AppColors.accentGold),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
