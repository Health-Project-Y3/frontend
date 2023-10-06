import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/forum/forum_drawer_widget.dart';
import 'package:thurula/views/forum/forum_question_widget.dart';
import '../../models/forum_question_model.dart';
import '../widgets/forum_navbar_widget.dart';
import 'forum_question_add_view.dart';

class ForumQuestionsOnTopicView extends StatefulWidget {
  final List<String> topic;

  final int pageIndex;

  const ForumQuestionsOnTopicView({Key? key, required this.topic, required this.pageIndex}) : super(key: key);

  @override
  State<ForumQuestionsOnTopicView> createState() =>
      _ForumQuestionsOnTopicViewState();
}

class _ForumQuestionsOnTopicViewState extends State<ForumQuestionsOnTopicView> {
  static const _pageSize = 10;
  final PagingController<int, ForumQuestion> _pagingController =
  PagingController(
    firstPageKey: 1,
    invisibleItemsThreshold: (_pageSize / 4).round(),
  );

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final nextPageQuestions = await ForumService.getQuestionsByKeywords(
        pageKey,
        _pageSize,
        widget.topic, // Pass the topic as a list with a single item
      );
      final isLastPage = nextPageQuestions.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(nextPageQuestions);
      } else {
        final nextPage = pageKey + 1;
        _pagingController.appendPage(nextPageQuestions, nextPage);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        title: const Text('Forum Questions'),
      ),
      bottomNavigationBar: CreateForumBottomNavigationBar(pageIndex: widget.pageIndex),
      drawer: const ForumDrawer(),
      body: Column(
        children: [
          // Add a container or card for the topic at the top
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color.fromARGB(255, 88, 119, 161), // Customize the background color
            child: Row(
              children: [
                const SizedBox(width: 15),
                Text(
                  'Topic:   ${widget.topic[0]}', // Display the topic name
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Customize the text color
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PagedListView<int, ForumQuestion>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<ForumQuestion>(
                itemBuilder: (context, question, index) =>
                    ForumQuestionCard(question: question),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddForumQuestionView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

