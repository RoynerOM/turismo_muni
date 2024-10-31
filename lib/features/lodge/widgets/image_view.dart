import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String footer;

  const FullScreenImage(
      {super.key, required this.imageUrl, required this.footer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Hero(
                  tag: 'imageHero_$imageUrl',
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: imageUrl,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                footer,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
