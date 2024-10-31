import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:turismo_upala/core/utils/device.dart';
import 'package:turismo_upala/features/lodge/pages/lodge_home_page.dart';
import 'package:turismo_upala/features/home/pages/home_page.dart';
import 'package:turismo_upala/features/service/pages/service_page.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  final pages = [
    const HomePage(scrollToAbout: false),
    ServicesPage(),
    const HomePage(scrollToAbout: true)
  ];

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
      Navigator.of(context)
          .pop(); // Cierra el menú lateral después de seleccionar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Device.width(context) <= 600
          ? AppBar(
              title: const Text('Turismo Upala'),
              backgroundColor: Colors.white,
              elevation: 0,
            )
          : AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NavItem(
                    name: 'Inicio',
                    selected: _currentIndex == 0,
                    onPressed: () {
                      setState(() => _currentIndex = 0);
                    },
                  ),
                  NavItem(
                    name: 'Nuestros Servicios',
                    selected: _currentIndex == 1,
                    onPressed: () {
                      setState(() => _currentIndex = 1);
                    },
                  ),
                  NavItem(
                    name: 'Quienes Somos',
                    selected: _currentIndex == 2,
                    onPressed: () {
                      setState(() => _currentIndex = 2);
                    },
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
      drawer: Device.width(context) > 600
          ? null
          : Drawer(
              width: 280,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://muniupala.go.cr/imagenes/turismo/img_671e753777c837.44950034.jpg',
                    ),
                  ),
                  NavItem(
                    name: 'Inicio',
                    selected: _currentIndex == 0,
                    onPressed: () => _navigateToPage(0),
                  ),
                  NavItem(
                    name: 'Nuestros Servicios',
                    selected: _currentIndex == 1,
                    onPressed: () => _navigateToPage(1),
                  ),
                  NavItem(
                    name: 'Quienes Somos',
                    selected: _currentIndex == 2,
                    onPressed: () => _navigateToPage(2),
                  ),
                ],
              ),
            ),
      body: pages[_currentIndex],
    );
  }
}
