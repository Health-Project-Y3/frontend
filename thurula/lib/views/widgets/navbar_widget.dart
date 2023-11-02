import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/providers/user_provider.dart';
import 'package:thurula/views/childcare/child_home_view.dart';

import 'package:thurula/views/menu_view.dart';
import 'package:thurula/views/forum/forum_home_view.dart';
import 'package:thurula/views/all_services_menu_view.dart';
import 'package:thurula/views/pregnancy/pregnancy_home_view.dart';

// create bottom navigation bar for pregnancy
class CreateBottomNavigationBar extends StatelessWidget {
  const CreateBottomNavigationBar({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: const Color.fromARGB(255, 220, 104, 145),
      unselectedItemColor: const Color.fromARGB(255, 88, 119, 161),
      selectedIconTheme: const IconThemeData(size: 30),
      selectedLabelStyle: const TextStyle(height: 0),
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.forum), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: ''),
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
            if (context.read<UserProvider>().user?.pregnant ?? false) {
              if (context.read<UserProvider>().user?.babyIDs != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuView(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PregnancyHomeView(),
                  ),
                );
              }
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChildHomeView(),
                ),
              );
            }
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllServices(),
              ),
            );
            break;
          default:
            if (context.read<UserProvider>().user?.pregnant ?? false) {
              if (context.read<UserProvider>().user?.babyIDs != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuView(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PregnancyHomeView(),
                  ),
                );
              }
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChildHomeView(),
                ),
              );
            }
            break;
        }
      },
    );
  }
}
