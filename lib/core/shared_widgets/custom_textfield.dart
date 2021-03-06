import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? initialValue;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.initialValue,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: initialValue,
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.blueGrey.shade100,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
      ),
    );
  }
}
