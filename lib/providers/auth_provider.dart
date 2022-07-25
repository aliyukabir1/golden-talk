import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;

  final instance = FirebaseAuth.instance;

  bool get isLoading => _isLoading;
  bool get isError => _isError;

  void setLoading(bool isloading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setError(bool isError) {
    _isError = isError;
    notifyListeners();
  }

  signUp(
      {required String email, required String password, String? name}) async {
    try {
      setLoading(true);
      await instance.createUserWithEmailAndPassword(
          email: email, password: password);
      final id = getCurrentUserId();
      FirebaseFirestore.instance.collection('users').doc(id).set({
        "name": name,
        'email': email,
        'uid': id,
        'photoUrl': null,
        'phoneNumber': null,
        'aboutMe': null
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

  login({required String email, required String password}) async {
    try {
      setLoading(true);
      await instance.signInWithEmailAndPassword(
          email: email, password: password);
      setLoading(false);
      Fluttertoast.showToast(msg: 'log in up successful');
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  bool isLoggedIn() {
    return instance.currentUser != null ? true : false;
  }

  Future<void> signOut() async {
    await instance.signOut();
  }

  String getCurrentUserId() {
    return instance.currentUser!.uid;
  }

  Future<DocumentSnapshot> getCurrentUserInfo() async {
    final id = getCurrentUserId();
    final data = FirebaseFirestore.instance.collection('users').doc(id).get();
    return data;
  }
}
