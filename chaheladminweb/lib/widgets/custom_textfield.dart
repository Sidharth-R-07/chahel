import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      this.hintText,
      this.labelText,
      required this.controller,
      this.maxLines,
      this.inputFormatters});
  final String? hintText;
  final String? labelText;
  final int? maxLines;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: inputFormatters,
      maxLines: maxLines ?? 1,
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText ?? "",
          labelText: labelText ?? ""),
    );
  }
}
