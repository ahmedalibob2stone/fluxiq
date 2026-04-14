import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int current;
  const PageIndicator({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
            (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 5,
          width: current == i ? 28 : 8,
          decoration: BoxDecoration(
            color: current == i ? Colors.white : Colors.white30,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
