import 'package:flutter/material.dart';

enum InputFieldType { name, email, password }

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
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
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    if (widget.customValidator != null) {
      final customError = widget.customValidator!(value);
      if (customError != null) return customError;
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        final reg = RegExp(r'^[a-zA-Zа-яА-ЯёЁ\s]+$');
        if (!reg.hasMatch(value)) {
          return 'Имя должно содержать только буквы и пробелы';
        }
        break;

      case InputFieldType.email:
        final reg = RegExp(r'^[\w.+-]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!reg.hasMatch(value)) {
          return 'Введите корректный email (например, test@mail.ru)';
        }
        break;

      case InputFieldType.password:
      // минимум 8 символов, есть буква, цифра и спецсимвол
        final reg = RegExp(
          r'^(?=.*[A-Za-zА-Яа-яЁё])(?=.*\d)(?=.*[^A-Za-zА-Яа-яЁё0-9]).{8,}$',
        );
        if (!reg.hasMatch(value)) {
          return 'Пароль от 8 символов (буквы, цифры и спецсимвол)';
        }
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.inputType == InputFieldType.password;

    TextInputType keyboardType;
    if (widget.inputType == InputFieldType.email) {
      keyboardType = TextInputType.emailAddress;
    } else if (widget.inputType == InputFieldType.name) {
      keyboardType = TextInputType.name;
    } else {
      keyboardType = TextInputType.text;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: isPassword && _hidePassword,
        keyboardType: keyboardType,
        validator: _validator,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _hidePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() => _hidePassword = !_hidePassword);
            },
          )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}