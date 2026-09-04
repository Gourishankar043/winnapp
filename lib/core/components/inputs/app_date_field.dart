import 'package:flutter/material.dart';
class AppDateField extends StatelessWidget{
  final TextEditingController controller;
  final String label;
  final VoidCallback onTap;
  final String? Function(String?)? validator;
  const AppDateField({
    super.key,
    required this.controller,
    required this.label,
    required this.onTap,
    this.validator,
});
  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: controller,
      readOnly: true,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(onPressed: onTap, icon: const Icon(Icons.calendar_today_outlined),),
      ),
    );
  }
}