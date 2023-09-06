import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    'Education'
    // Add more route names as needed
  ];

  final List<IconData> icons = [
    Icons.local_dining,
    Icons.local_hospital,
    Icons.school
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
            accountName: Text(
                '${context.read<UserProvider>().user?.fname} ${context.read<UserProvider>().user!.lname}'),
            accountEmail: Text(context.read<UserProvider>().user?.email ?? ''),
            currentAccountPicture: const CircleAvatar(
              // Add your profile picture here
              backgroundImage: AssetImage('assets/profile_picture.png'),
            ),
          ),
          // Generate "My Questions" ListTile
          ListTile(
            leading: const Icon(Icons.my_library_books),
            title: const Text('My Questions'),
            onTap: () {
              // Add navigation to "My Questions" page here
              Navigator.pop(context); // Close the drawer
              // Add code to navigate to "My Questions" page
            },
          ),
          const Divider(), // Add a divider for visual separation
          // Generate list of other ListTile items dynamically
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
