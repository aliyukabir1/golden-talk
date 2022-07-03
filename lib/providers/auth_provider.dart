import 'package:flutter/cupertino.dart';

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
    setLoading(true);
    try {
      await si.authServices.signUp(email, password, name);
    } on Exception {
      setError(true);
    }
    setLoading(false);
  }

  login({required String email, required String password}) async {
    setLoading(true);
    try {
      await si.authServices.login(email, password);
    } on Exception {
      setError(true);
    }
  }
}
