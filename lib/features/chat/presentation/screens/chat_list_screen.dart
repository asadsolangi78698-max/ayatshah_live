import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/message_model.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder threads — replace with a provider backed by
    // ApiEndpoints.chats once the backend is connected.
    const threads = <ChatThreadModel>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: threads.isEmpty
          ? const Center(
              child: Text('No conversations yet',
                  style: TextStyle(color: AppColors.textMuted)),
            )
          : ListView.separated(
              itemCount: threads.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final thread = threads[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: thread.otherUserAvatarUrl.isNotEmpty
                        ? NetworkImage(thread.otherUserAvatarUrl)
                        : null,
                    backgroundColor: AppColors.primary,
                  ),
                  title: Text(thread.otherUserName),
                  subtitle: Text(
                    thread.lastMessage ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: thread.unreadCount > 0
                      ? CircleAvatar(
                          radius: 9,
                          backgroundColor: AppColors.primary,
                          child: Text('${thread.unreadCount}',
                              style: const TextStyle(fontSize: 10, color: Colors.white)),
                        )
                      : null,
                  onTap: () => context.push('/chat/${thread.id}'),
                );
              },
            ),
    );
  }
}
