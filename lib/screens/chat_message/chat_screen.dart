import 'package:chat_app/core/shared_widgets/custom_textfield.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/screens/chat_message/components/left_text.dart';
import 'package:chat_app/screens/chat_message/components/right_text.dart';
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
                child: Column(
                  children: const [LeftTextDisplay(), RightTextDisPlay()],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25)),
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
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25)),
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
            )
          ],
        ),
      ),
    );
  }
}
