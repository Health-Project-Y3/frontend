import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/forum/forum_drawer_widget.dart';
import 'package:thurula/views/forum/forum_question_widget.dart';
import 'package:thurula/views/widgets/navbar_widget.dart';
import '../../models/forum_question_model.dart';
import '../../providers/user_provider.dart';

class ForumMyQuestionsView extends StatefulWidget {
  const ForumMyQuestionsView({Key? key}) : super(key: key);

  @override
  State<ForumMyQuestionsView> createState() =>
      _ForumQuestionsOnTopicViewState();
}

class _ForumQuestionsOnTopicViewState extends State<ForumMyQuestionsView> {
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
      final nextPageQuestions = await ForumService.getQuestionsByAuthor(
        context.read<UserProvider>().user!.id!,
        pageKey,
        _pageSize,
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
      bottomNavigationBar: const CreateBottomNavigationBar(pageIndex: 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        title: const Text('My Questions'),
      ),
      drawer: const ForumDrawer(),
      body: Column(
        children: [
          // Add a container or card for the topic at the top
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
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

