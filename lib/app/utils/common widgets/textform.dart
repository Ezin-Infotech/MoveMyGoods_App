import 'package:flutter/material.dart';

class TextFormFieldWidgets extends StatelessWidget {
  const TextFormFieldWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter a search term',
      ),
    );
  }
}
