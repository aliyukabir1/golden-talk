import 'dart:io';

import 'package:chat_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileProvider extends ChangeNotifier {
  bool isImageLoading = false;
  bool isLoading = false;

  setImageLoading(bool bool) {
    isImageLoading = bool;
    notifyListeners();
  }

  setLoading(bool bool) {
    isLoading = bool;
    notifyListeners();
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  updateProfilePicture(File file) {
    try {
      setImageLoading(true);
      storage
          .ref('profile')
          .child(currentUserId)
          .putFile(file)
          .then((p0) async {
        final url = await p0.ref.getDownloadURL();
        final data = {'photoUrl': url};
        firestore.collection('users').doc(currentUserId).update(data);
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? 'check connection');
    }
    setImageLoading(false);
  }

  Future<void> updateProfileInfo(UserModel user) async {
    setLoading(true);
    try {
      final data = user.toJson();
      await firestore.collection('users').doc(currentUserId).update(data);
    } catch (e) {
      rethrow;
    }
    setLoading(false);
  }
}
