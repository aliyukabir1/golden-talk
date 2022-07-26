import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider extends ChangeNotifier {
// instances of firebase
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  // if i decide to add isLoading and Error
  bool _isLoading = false;
  bool _isError = false;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

// toggles for isLoading and isError
  void setLoading(bool isloading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setError(bool isError) {
    _isError = isError;
    notifyListeners();
  }

// sign up and creating a user collection with the user id
  signUp(
      {required String email, required String password, String? name}) async {
    try {
      setLoading(true);
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final id = getCurrentUserId();
      firestore.collection('users').doc(id).set({
        "name": name ?? '',
        'email': email,
        'uid': id,
        'photoUrl': '',
        'phoneNumber': '',
        'aboutMe': ''
      });
      setLoading(false);
      Fluttertoast.showToast(msg: 'sign up successful');
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

// login
  login({required String email, required String password}) async {
    try {
      setLoading(true);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      setLoading(false);
      Fluttertoast.showToast(msg: 'log in up successful');
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

// to check if there's a user logged in or not
  bool isLoggedIn() {
    return auth.currentUser != null ? true : false;
  }

// for signing out
  Future<void> signOut() async {
    await auth.signOut();
  }

// to return current user id
  String getCurrentUserId() {
    return auth.currentUser!.uid;
  }

// get the information of the current user
  Future<DocumentSnapshot> getCurrentUserInfo() async {
    final id = getCurrentUserId();
    final data = firestore.collection('users').doc(id).get();
    return data;
  }
}
