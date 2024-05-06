import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final bool? isObscure;
  final Icon iconData;
  final String fieldName;
  final TextEditingController controller;

  const InputTextField({
    Key? key,
    this.isObscure,
    required this.iconData,
    required this.fieldName,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure != null ? isObscure! : false,
      decoration: InputDecoration(
        prefixIcon: iconData,
        labelText: fieldName,
        hintText: fieldName,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
