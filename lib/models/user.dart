import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid, name, aboutMe, phoneNumber, photoUrl;

  User(
      {required this.photoUrl,
      required this.uid,
      required this.name,
      required this.aboutMe,
      required this.phoneNumber});

  factory User.fromDocument(DocumentSnapshot snapshot) {
    String photoUrl, uid, name, aboutMe, phoneNumber = '';
    photoUrl = snapshot.get('photoUrl');
    uid = snapshot.get('uid');
    name = snapshot.get('name');
    aboutMe = snapshot.get('aboutMe');
    phoneNumber = snapshot.get('phoneNumber');
    return User(
        uid: uid,
        name: name,
        aboutMe: aboutMe,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl);
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'aboutMe': aboutMe,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl
    };
  }

  copyWith(
      {String? uid,
      String? name,
      String? aboutMe,
      String? phoneNumber,
      String? photoUrl}) {
    return User(
        photoUrl: photoUrl ?? this.photoUrl,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        aboutMe: aboutMe ?? this.aboutMe,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }
}
