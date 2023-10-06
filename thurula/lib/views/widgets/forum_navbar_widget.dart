import 'package:flutter/material.dart';
import 'package:thurula/views/forum/forum_questions_mine_view.dart';
import 'package:thurula/views/forum/forum_questions_on_topic_view.dart';

import 'package:thurula/views/forum/forum_home_view.dart';


// create bottom navigation bar for pregnancy
class CreateForumBottomNavigationBar extends StatelessWidget {
  const CreateForumBottomNavigationBar({super.key, required this.pageIndex});

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
            icon: Icon(Icons.insert_emoticon), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_dining), label: ''),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_hospital),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.school), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.pregnant_woman), label: ''),
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
                builder: (context) => const ForumMyQuestionsView(),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForumQuestionsOnTopicView(topic: ['Nutrition'], pageIndex: 2,),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForumQuestionsOnTopicView(topic: ['Health'], pageIndex: 3,),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForumQuestionsOnTopicView(topic: ['Education'], pageIndex: 4,),
              ),
            );
            break;
          case 5:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForumQuestionsOnTopicView(topic: ['Pregnancy'], pageIndex: 5,),
              ),
            );
            break;
        }
      },
    );
  }
}