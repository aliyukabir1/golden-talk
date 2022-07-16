import 'dart:io';

import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatProvider {
  final instance = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  Future<void> sendChat(
      {required String content,
      required int type,
      required String groupChatId,
      required String currentUserId,
      required String peerUserId}) async {
    DocumentReference ref = instance
        .collection('chats')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    Message message = Message(
        idFrom: currentUserId,
        idTo: peerUserId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);

    await FirebaseFirestore.instance.runTransaction(
        (transaction) async => transaction.set(ref, message.toJson()));
  }

  Stream<QuerySnapshot> getMessages(
      {required String groupChatId, required int limit}) {
    return instance
        .collection('chats')
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy('timeStamp')
        .limit(limit)
        .snapshots();
  }

  UploadTask uploadImageFile(File image, String filename) {
    Reference reference = firebaseStorage.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateFirestoreData(
      Map<String, dynamic> data, String docPath) async {
    return await instance.collection('chats').doc(docPath).update(data);
  }
}

class MessageType {
  static const text = 0;
  static const image = 1;
}
