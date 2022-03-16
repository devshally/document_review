import 'package:flutter/material.dart';

///A custom TextFieldWidget for taking user input.
class TextFieldWidget extends StatelessWidget {
  ///
  final TextEditingController controller;

  ///
  final String label;

  ///The constructor takes a controller and label,
  // ignore: sort_constructors_first
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          label,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
      ),
    );
  }
}
