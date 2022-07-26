import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid, email, name, aboutMe, phoneNumber, photoUrl;

  UserModel(
      {required this.photoUrl,
      required this.email,
      required this.uid,
      required this.name,
      required this.aboutMe,
      required this.phoneNumber});

  factory UserModel.fromDocument(DocumentSnapshot snapshot) {
    String photoUrl, email, uid, name, aboutMe, phoneNumber = '';
    photoUrl = snapshot.get('photoUrl');
    uid = snapshot.get('uid');
    name = snapshot.get('name');
    aboutMe = snapshot.get('aboutMe');
    phoneNumber = snapshot.get('phoneNumber');
    email = snapshot.get('email');
    return UserModel(
        email: email,
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
      'photoUrl': photoUrl,
      'email': email
    };
  }

  copyWith(
      {String? uid,
      String? name,
      String? email,
      String? aboutMe,
      String? phoneNumber,
      String? photoUrl}) {
    return UserModel(
        photoUrl: photoUrl ?? this.photoUrl,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        aboutMe: aboutMe ?? this.aboutMe,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email);
  }
}
