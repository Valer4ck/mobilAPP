import 'package:flutter/material.dart';

enum InputFieldType { name, email, password }

class CustomTextFormField extends StatelessWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? customValidator;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.customValidator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: inputType == InputFieldType.password,
      keyboardType: inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: customValidator ??
              (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Заполните поле';
            }
            if (inputType == InputFieldType.email && !value.contains('@')) {
              return 'Некорректный email';
            }
            if (inputType == InputFieldType.password && value.length < 6) {
              return 'Минимум 6 символов';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}