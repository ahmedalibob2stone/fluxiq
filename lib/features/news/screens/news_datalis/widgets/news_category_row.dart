import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsCategoryRow extends StatelessWidget {
  final String category;
  final DateTime createdAt;

  const NewsCategoryRow({
    required this.category,
    required this.createdAt,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          category,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Text(
          DateFormat.yMMMd().format(createdAt),
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}