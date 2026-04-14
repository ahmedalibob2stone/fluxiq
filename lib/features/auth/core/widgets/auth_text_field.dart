  import 'package:flutter/material.dart';


class AuthTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Key? fieldKey;

  const AuthTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.keyboardType,
    this.validator,
    this.fieldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: TextFormField(
      key: key,
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(),
      ),
    ),
  );
}