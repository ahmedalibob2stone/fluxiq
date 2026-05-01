import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewsImageField extends StatefulWidget {
  final TextEditingController controller;

  const CreateNewsImageField({Key? key, required this.controller})
      : super(key: key);

  @override
  State<CreateNewsImageField> createState() => _CreateNewsImageFieldState();
}

class _CreateNewsImageFieldState extends State<CreateNewsImageField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        TextField(
          controller: widget.controller,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            labelText: 'Image URL',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.image),
          ),
          keyboardType: TextInputType.url,
        ),
        const SizedBox(height: 8),
        if (widget.controller.text.trim().isNotEmpty)
          SizedBox(
            height: size.height * 0.25,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.controller.text.trim(),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
          ),
      ],
    );
  }
}