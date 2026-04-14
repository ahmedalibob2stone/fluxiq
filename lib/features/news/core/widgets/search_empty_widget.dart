import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No matching news found',
            style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Try searching for something else',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}