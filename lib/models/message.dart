import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String idFrom;
  final String idTo;
  final String timestamp;
  final String content;
  final int type;

  Message(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  factory Message.fromDocument(DocumentSnapshot documentSnapshot) {
    return Message(
        idFrom: documentSnapshot['idFrom'],
        idTo: documentSnapshot['idTo'],
        timestamp: documentSnapshot['timeStamp'],
        content: documentSnapshot['content'],
        type: documentSnapshot['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'idFrom': idFrom,
      'idTo': idTo,
      'timeStamp': timestamp,
      'content': content,
      'type': type
    };
  }
}
