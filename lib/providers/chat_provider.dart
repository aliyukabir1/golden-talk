import 'dart:io';

import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatProvider {
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  // for sending a message
  Future<void> sendChat(
      {required String content,
      required int type,
      required String groupChatId,
      required String currentUserId,
      required String peerUserId}) async {
    DocumentReference ref = firestore
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

// getting stream of messages exchanged
  Stream<QuerySnapshot> getMessages(
      {required String groupChatId, required int limit}) {
    return firestore
        .collection('chats')
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy('timeStamp')
        .limit(limit)
        .snapshots();
  }

// to upload file as message
  uploadImageFile(File image, String filename) async {
    final reference = await storage
        .ref('image')
        .putFile(image)
        .then((p0) => p0.ref.getDownloadURL());
    return reference;
  }

//not really show if im gonna need this
  Future<void> updateFirestoreData(
      Map<String, dynamic> data, String docPath) async {
    return await firestore.collection('chats').doc(docPath).update(data);
  }
}

class MessageType {
  static const text = 0;
  static const image = 1;
}
