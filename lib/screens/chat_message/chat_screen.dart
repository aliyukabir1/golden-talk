import 'package:chat_app/models/message.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/screens/chat_message/components/left_text.dart';
import 'package:chat_app/screens/chat_message/components/message_input.dart';
import 'package:chat_app/screens/chat_message/components/right_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String otherUserId, otherUserAvatar, otherUserName;

  const ChatScreen(
      {Key? key,
      required this.otherUserId,
      required this.otherUserAvatar,
      required this.otherUserName})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textController = TextEditingController();
  late ChatProvider chatProvider;
  late AuthProvider authProvider;
  late String currentUserId;
  late String groupChatId;
  @override
  void initState() {
    chatProvider = context.read<ChatProvider>();
    authProvider = context.read<AuthProvider>();
    currentUserId = authProvider.getCurrentUserId();
    if (currentUserId.compareTo(widget.otherUserId) > 0) {
      groupChatId = '$currentUserId - ${widget.otherUserId}';
    } else {
      groupChatId = '${widget.otherUserId} - $currentUserId';
    }
    super.initState();
  }

  onSendMessage(String content, int type) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatting with ${widget.otherUserName}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: chatProvider.getMessages(
                            groupChatId: groupChatId, limit: 20),
                        builder: (context, snapshot) {
                          return ListView.builder(
                              itemBuilder: (context, index) {
                            if (snapshot.hasData) {
                              final messageList = snapshot.data!.docs;
                              Message message =
                                  Message.fromDocument(messageList[index]);
                              if (message.idFrom == currentUserId) {
                                return RightTextDisPlay(message: message);
                              }
                              return LeftTextDisplay(message: message);
                            }
                            return const Center(child: Text('no messages'));
                          });
                        }))),
            MessageInput(
                textController: textController,
                chatProvider: chatProvider,
                groupChatId: groupChatId,
                currentUserId: currentUserId,
                widget: widget)
          ],
        ),
      ),
    );
  }
}
