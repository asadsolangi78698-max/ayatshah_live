enum MessageType { text, image, voice }

class MessageModel {
  const MessageModel({
    required this.id,
    required this.senderId,
    required this.type,
    this.text,
    this.mediaUrl,
    this.durationSeconds,
    required this.sentAt,
    this.isMine = false,
  });

  final String id;
  final String senderId;
  final MessageType type;
  final String? text;
  final String? mediaUrl;
  final int? durationSeconds;
  final DateTime sentAt;
  final bool isMine;
}

class ChatThreadModel {
  const ChatThreadModel({
    required this.id,
    required this.otherUserId,
    required this.otherUserName,
    required this.otherUserAvatarUrl,
    this.lastMessage,
    this.unreadCount = 0,
  });

  final String id;
  final String otherUserId;
  final String otherUserName;
  final String otherUserAvatarUrl;
  final String? lastMessage;
  final int unreadCount;
}
