class MicSeatModel {
  const MicSeatModel({
    required this.seatIndex,
    this.userId,
    this.userName,
    this.avatarUrl,
    this.isLocked = false,
    this.isMuted = false,
    this.isSpeaking = false,
  });

  final int seatIndex;
  final String? userId;
  final String? userName;
  final String? avatarUrl;
  final bool isLocked;
  final bool isMuted;
  final bool isSpeaking;

  bool get isEmpty => userId == null;

  factory MicSeatModel.fromJson(Map<String, dynamic> json) => MicSeatModel(
        seatIndex: json['seatIndex'] as int,
        userId: json['userId'] as String?,
        userName: json['userName'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        isLocked: json['isLocked'] as bool? ?? false,
        isMuted: json['isMuted'] as bool? ?? false,
        isSpeaking: json['isSpeaking'] as bool? ?? false,
      );
}

class AudioRoomModel {
  const AudioRoomModel({
    required this.id,
    required this.title,
    required this.hostId,
    required this.seats,
    this.announcement,
  });

  final String id;
  final String title;
  final String hostId;
  final List<MicSeatModel> seats;
  final String? announcement;

  factory AudioRoomModel.fromJson(Map<String, dynamic> json) => AudioRoomModel(
        id: json['id'] as String,
        title: json['title'] as String? ?? '',
        hostId: json['hostId'] as String,
        announcement: json['announcement'] as String?,
        seats: (json['seats'] as List<dynamic>? ?? [])
            .map((e) => MicSeatModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
