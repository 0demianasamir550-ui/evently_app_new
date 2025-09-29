import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final Color? iconColor;
  final Color? textColor;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextColor = theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF7B7B7B);
    final defaultIconColor = theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF7B7B7B);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: textColor ?? defaultTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: textColor ?? defaultTextColor),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: iconColor ?? defaultIconColor) : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}