import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/injector.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;

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
      await si.authServices.signUp(email, password, name);
      setLoading(false);
      Fluttertoast.showToast(msg: 'sign up successful');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    } catch (e) {
      Fluttertoast.showToast(msg: 'oops check your connection');
    }
    notifyListeners();
  }

  login({required String email, required String password}) async {
    try {
      setLoading(true);
      await si.authServices.login(email, password);
      setLoading(false);
      Fluttertoast.showToast(msg: 'sign up successful');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    } catch (e) {
      Fluttertoast.showToast(msg: 'oops check your connection');
    }
  }
}
