import 'dart:io';

import 'package:chat_app/core/shared_widgets/custom_textfield.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/screens/chat_message/chat_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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
    onSendMessage(String content, int type) async {
      if (content.trim().isNotEmpty) {
        textController.clear();
        await chatProvider.sendChat(
            content: content,
            type: type,
            groupChatId: groupChatId,
            currentUserId: currentUserId,
            peerUserId: widget.otherUserId);
      }
    }

    uploadImageFile({required File imageFile}) async {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      try {
        String imageUrl =
            await chatProvider.uploadImageFile(imageFile, fileName);
        onSendMessage(imageUrl, MessageType.image);
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: e.message ?? e.toString());
      }
    }

    getImage() async {
      ImagePicker imagePicker = ImagePicker();
      XFile? pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final imageFile = File(pickedImage.path);
        uploadImageFile(imageFile: imageFile);
      }
    }

    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(25)),
            child: IconButton(
                onPressed: () {
                  getImage();
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 20,
                )),
          ),
          Flexible(
              child: CustomTextField(
            hintText: 'Type here',
            controller: textController,
            keyboardType: TextInputType.multiline,
          )),
          Container(
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(25)),
            child: IconButton(
                onPressed: () {
                  onSendMessage(textController.text, MessageType.text);
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
