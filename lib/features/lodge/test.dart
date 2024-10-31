import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  const CardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFD2DBDD),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardItem(
                      category: 'Recipe',
                      title: 'Crisp Spanish tortilla Matzo brei',
                      author: 'Celeste Mills',
                      time: '15 min',
                      imageUrl:
                          'https://muniupala.go.cr/imagenes/turismo/img_671e753777c837.44950034.jpg',
                    ),
                    SizedBox(width: 16),
                    CardItem(
                      category: 'Travel',
                      title: 'Discover the sea',
                      author: 'John Doe',
                      time: '5 min',
                      imageUrl:
                          'https://muniupala.go.cr/imagenes/turismo/img_671e753777c837.44950034.jpg',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  final String category;
  final String title;
  final String author;
  final String time;
  final String imageUrl;

  const CardItem({
    super.key,
    required this.category,
    required this.title,
    required this.author,
    required this.time,
    required this.imageUrl,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      children: [
                        Icon(Icons.lock_clock),
                        const SizedBox(width: 5),
                        Text(
                          widget.time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFAD7D52),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Contenido de la tarjeta
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 13,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF868686),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'by ${widget.author}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFAD7D52),
                      ),
                    ),
                  ],
                ),
              ),
              // Imagen de fondo
              Container(
                height: 235,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Icono y tiempo en la esquina superior derecha
            ],
          ),
        ),
      ),
    );
  }
}
