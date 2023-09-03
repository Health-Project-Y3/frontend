import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/forum/forum_question_widget.dart';
import '../../models/forum_question_model.dart';

class ForumHomeView extends StatefulWidget {
  const ForumHomeView({Key? key}) : super(key: key);

  @override
  State<ForumHomeView> createState() => _ForumHomeViewState();
}

class _ForumHomeViewState extends State<ForumHomeView> {
  static const _pageSize = 10;
  final PagingController<int, ForumQuestion> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final nextPageQuestions =
      await ForumService.getRecentQuestions(pageKey, _pageSize);
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
        title: const Text('Recent Forum Questions'),
      ),
      body: PagedListView<int, ForumQuestion>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ForumQuestion>(
          itemBuilder: (context, question, index) =>
              ForumQuestionCard(question: question),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
