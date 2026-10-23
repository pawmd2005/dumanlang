import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}