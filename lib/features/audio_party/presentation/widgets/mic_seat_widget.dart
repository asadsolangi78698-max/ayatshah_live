import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/audio_room_model.dart';

class MicSeatWidget extends StatelessWidget {
  const MicSeatWidget({super.key, required this.seat, required this.onTap});

  final MicSeatModel seat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceElevated,
              border: Border.all(
                color: seat.isSpeaking ? AppColors.success : Colors.transparent,
                width: 2,
              ),
            ),
            child: seat.isEmpty
                ? Icon(
                    seat.isLocked ? Icons.lock_outline : Icons.mic_none,
                    color: AppColors.textMuted,
                  )
                : ClipOval(
                    child: seat.avatarUrl != null
                        ? Image.network(seat.avatarUrl!, fit: BoxFit.cover)
                        : const Icon(Icons.person, color: AppColors.textMuted),
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            seat.isEmpty ? 'Seat ${seat.seatIndex + 1}' : (seat.userName ?? ''),
            style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (seat.isMuted && !seat.isEmpty)
            const Icon(Icons.mic_off, size: 12, color: AppColors.error),
        ],
      ),
    );
  }
}
