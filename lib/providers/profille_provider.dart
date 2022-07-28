import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileProvider {
  FirebaseStorage storage = FirebaseStorage.instance;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  updateProfilePicture(File file) {
    try {
      storage
          .ref('profile')
          .child(currentUserId)
          .putFile(file)
          .then((p0) async {
        final url = await p0.ref.getDownloadURL();
        final data = {'photoUrl': url};
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .update(data);
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? 'check connection');
    }
  }
}
