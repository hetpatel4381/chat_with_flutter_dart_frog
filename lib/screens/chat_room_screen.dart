import 'package:chat_with_flutter_dart_frog/widgets/circle_avatar.dart';
import 'package:chat_with_flutter_dart_frog/main.dart';
import 'package:chat_with_flutter_dart_frog/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.chatRoom});
  final ChatRoom chatRoom;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final messageController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    super.dispose();
  }

  final List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    final currentParticipant =
        widget.chatRoom.participants.firstWhere((user) => user.id != userId1);

    final otherParticipant = widget.chatRoom.participants
        .firstWhere((user) => user.id != currentParticipant.id);

    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          Avatar(imageUrl: otherParticipant.avatarUrl, radius: 18),
          // const SizedBox(height: 2.0),
          Text(otherParticipant.username,
              style: Theme.of(context).textTheme.bodySmall),
        ]),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: (viewInsets.bottom > 0) ? 12 : 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final showImage = index + 1 == messages.length ||
                        messages[index + 1].senderUserId !=
                            message.senderUserId;

                    return Row(
                      mainAxisAlignment: (message.senderUserId != userId1) ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if(showImage && message.senderUserId == userId1)
                          Avatar(imageUrl: otherParticipant.avatarUrl, radius: 12),
                        MessageBubble(message: message),
                        if (showImage && message.senderUserId != userId1)
                          Avatar(
                              imageUrl: otherParticipant.avatarUrl, radius: 12),
                      ],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // Send an Image.
                      },
                      icon: const Icon(Icons.attach_file)),
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primary,
                        hintText: "Type a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(onPressed: (){
                          //Send a Message and clear the controller.
                        }, icon: const Icon(Icons.send)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
