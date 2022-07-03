import 'package:flutter/material.dart';
import 'package:snack/snack.dart';

class Util {
  showToast(BuildContext context, String message) {
    final bar = SnackBar(content: Center(child: Text(message)));
    bar.show(context);
  }
}
