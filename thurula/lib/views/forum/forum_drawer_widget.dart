import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/views/forum/forum_home_view.dart';
import 'package:thurula/views/forum/forum_questions_mine_view.dart';
import 'package:thurula/views/forum/forum_questions_on_topic_view.dart';
import '../../providers/user_provider.dart';

class ForumDrawer extends StatefulWidget {
  const ForumDrawer({Key? key}) : super(key: key);

  @override
  State<ForumDrawer> createState() => _ForumDrawerState();
}

class _ForumDrawerState extends State<ForumDrawer> {
  // Define arrays for other routes, icons, and titles
  final List<String> routes = [
    'Nutrition',
    'Health',
    'Education',
    'Pregnancy'
    // Add more route names as needed
  ];

  final List<IconData> icons = [
    Icons.local_dining,
    Icons.local_hospital,
    Icons.school,
    Icons.pregnant_woman
    // Add more icons as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header with a CircleAvatar and name
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 220, 104, 145),
            ),
            accountName: Text(
                '${context.read<UserProvider>().user?.fname} ${context.read<UserProvider>().user!.lname}'),
            accountEmail: Text(context.read<UserProvider>().user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              // Add your profile picture here
              // backgroundImage: AssetImage('assets/profile_picture.png'),
              // backgroundColor: Colors.primaries[
              // context.read<UserProvider>().user!.fname![0].codeUnitAt(0) %
              //     Colors.primaries.length],
              backgroundColor: const Color.fromARGB(255, 88, 119, 161),
              child: Text(
                '${context.read<UserProvider>().user!.fname?[0]}${context.read<UserProvider>().user?.lname?[0]}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Generate "My Questions" ListTile
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Add navigation to "Home" page here
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForumHomeView(),
                ),
              );
              // Add code to navigate to "Home" page
            },
          ),
          ListTile(
            leading: const Icon(Icons.my_library_books),
            title: const Text('My Questions'),
            onTap: () {
              // Add navigation to "My Questions" page here
              Navigator.pop(context); // Close the drawer
              // Add code to navigate to "My Questions" page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForumMyQuestionsView(),
                ),
              );
            },
          ),
          const Divider(), // Add a divider for visual separation
          // Generate list of other ListTile items dynamically
          //Add a title for the list of topics
          const ListTile(
            title: Text(
              'Topics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (int i = 0; i < routes.length; i++)
            ListTile(
              leading: Icon(icons[i]),
              title: Text(routes[i]),
              onTap: () {
                // Handle tapping on the corresponding route
                Navigator.pop(context); // Close the drawer
                // You can navigate to the selected route here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForumQuestionsOnTopicView(
                      topic: [routes[i]],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
