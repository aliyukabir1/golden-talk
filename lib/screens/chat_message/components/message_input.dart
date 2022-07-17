import 'package:chat_app/core/shared_widgets/custom_textfield.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/screens/chat_message/chat_screen.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    Key? key,
    required this.textController,
    required this.chatProvider,
    required this.groupChatId,
    required this.currentUserId,
    required this.widget,
  }) : super(key: key);

  final TextEditingController textController;
  final ChatProvider chatProvider;
  final String groupChatId;
  final String currentUserId;
  final ChatScreen widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(25)),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.camera_alt,
                  size: 20,
                )),
          ),
          Flexible(
              child: CustomTextField(
            hintText: 'Type here',
            controller: textController,
          )),
          Container(
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(25)),
            child: IconButton(
                onPressed: () async {
                  final content = textController.text;
                  if (content.trim().isNotEmpty) {
                    textController.clear();
                    await chatProvider.sendChat(
                        content: content,
                        type: 0,
                        groupChatId: groupChatId,
                        currentUserId: currentUserId,
                        peerUserId: widget.otherUserId);
                  }
                },
                icon: const Icon(
                  Icons.send_rounded,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}
