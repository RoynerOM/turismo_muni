import 'package:flutter/material.dart';

class Vinetas extends StatelessWidget {
  const Vinetas({
    super.key,
    required this.title,
    this.data = const [],
  });
  final String title;
  final List<String> data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (var x in data)
          Row(
            children: [
              const Icon(
                Icons.circle,
                color: Colors.black,
                size: 12,
              ),
              const SizedBox(width: 12),
              Text(
                x,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          )
      ],
    );
  }
}
