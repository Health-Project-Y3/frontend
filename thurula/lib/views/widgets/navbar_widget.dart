import 'package:flutter/material.dart';

import 'package:thurula/views/menu_view.dart';
import 'package:thurula/views/forum/forum_home_view.dart';
import 'package:thurula/views/all_services_menu_view.dart';

// create bottom navigation bar for pregnancy
class CreateBottomNavigationBar extends StatelessWidget {
  const CreateBottomNavigationBar({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: const Color.fromARGB(255, 88, 119, 161),
      unselectedItemColor: const Color.fromARGB(255, 220, 104, 145),
      selectedIconTheme: const IconThemeData(size: 30),
      selectedLabelStyle: const TextStyle(height: 0),
      type: BottomNavigationBarType.fixed,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.forum), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.apps), label: ''),
      ],
      currentIndex: pageIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForumHomeView(),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuView(),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllServices(),
              ),
            );
            break;
        }
      },
    );
  }
}