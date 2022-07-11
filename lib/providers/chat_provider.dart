import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider {
  final instance = FirebaseFirestore.instance;
  // final firebaseStorage = FirebaseStorage.instance;
  void sendChat(
      {required String content,
      required int type,
      required String groupChatId,
      required String currentUserId,
      required String peerUserId}) {
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

    FirebaseFirestore.instance
        .runTransaction((transaction) async => transaction.set(ref, message));
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

  Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return instance.collection(collectionPath).doc(docPath).update(dataUpdate);
  }

  // UploadTask uploadImageFile(File image, String filename) {
  //   Reference reference = firebaseStorage.ref().child(filename);
  //   UploadTask uploadTask = reference.putFile(image);
  //   return uploadTask;
  // }
}

class MessageType {
  static const text = 0;
  static const image = 1;
}
