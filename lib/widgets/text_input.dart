import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({Key? key, this.controller, this.label, this.onChanged}) : super(key: key);
  final TextEditingController? controller;
  final String? label;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        labelText: label,
        contentPadding: const EdgeInsets.all(13),
      ),
    );
  }
}
