import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewsTitleField extends StatelessWidget {
  final TextEditingController controller;

  const CreateNewsTitleField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.title),
      ),
    );
  }
}