import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewsDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const CreateNewsDescriptionField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.description),
      ),
      maxLines: 5,
    );
  }
}