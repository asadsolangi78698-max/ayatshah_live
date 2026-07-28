class LiveRoomModel {
  const LiveRoomModel({
    required this.id,
    required this.hostId,
    required this.hostName,
    required this.hostAvatarUrl,
    required this.title,
    required this.viewerCount,
    this.thumbnailUrl,
    this.country,
    this.isPkActive = false,
  });

  final String id;
  final String hostId;
  final String hostName;
  final String hostAvatarUrl;
  final String title;
  final int viewerCount;
  final String? thumbnailUrl;
  final String? country;
  final bool isPkActive;

  factory LiveRoomModel.fromJson(Map<String, dynamic> json) => LiveRoomModel(
        id: json['id'] as String,
        hostId: json['hostId'] as String,
        hostName: json['hostName'] as String? ?? '',
        hostAvatarUrl: json['hostAvatarUrl'] as String? ?? '',
        title: json['title'] as String? ?? '',
        viewerCount: json['viewerCount'] as int? ?? 0,
        thumbnailUrl: json['thumbnailUrl'] as String?,
        country: json['country'] as String?,
        isPkActive: json['isPkActive'] as bool? ?? false,
      );
}
