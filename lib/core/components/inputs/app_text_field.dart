import 'package:flutter/material.dart';

import '../../theme/app_dimensions.dart';

class AppTextField extends StatelessWidget{
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final int maxLines;
  const AppTextField ({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.keyboardType,
    this.obscureText=false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.enabled=true,
    this.maxLines=1,
});
  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon==null?null:Icon(prefixIcon),
        suffixIcon: suffixIcon,
        constraints: const BoxConstraints(
          minHeight: AppDimensions.inputHeight,
        ),
      ),
    );
  }
}