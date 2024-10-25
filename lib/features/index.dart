import 'package:flutter/material.dart';
import 'package:turismo_upala/features/experience/pages/experience_home_page.dart';
import 'package:turismo_upala/features/home/pages/home_page.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  final pages = [HomePage(), Scaffold(), Scaffold()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: pages[_currentIndex],
    );
  }
}
