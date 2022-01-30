import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key? key, this.controller, this.label, this.onChanged, this.suffixIcon, this.keyboardType,this.maxLines = 1,this.enabled})
      : super(key: key);
  final TextEditingController? controller;
  final Icon? suffixIcon;
  final String? label;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      onChanged: onChanged,
      keyboardType:keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        labelText: label,
        contentPadding: const EdgeInsets.all(13),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
