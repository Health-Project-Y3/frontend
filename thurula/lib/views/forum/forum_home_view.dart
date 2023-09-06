import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/forum/forum_drawer_widget.dart';
import 'package:thurula/views/forum/forum_question_widget.dart';
import '../../models/forum_question_model.dart';
import 'forum_add_question_view.dart';
import 'forum_search_delegate.dart';

class ForumHomeView extends StatefulWidget {
  const ForumHomeView({Key? key}) : super(key: key);

  @override
  State<ForumHomeView> createState() => _ForumHomeViewState();
}

class _ForumHomeViewState extends State<ForumHomeView> {
  String _searchQuery = '';
  static const _pageSize = 10;
  final PagingController<int, ForumQuestion> _pagingController =
      PagingController(
          firstPageKey: 1, invisibleItemsThreshold: (_pageSize / 4).round());

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      if (_searchQuery.isEmpty) {
        _fetchPage(pageKey);
      } else {
        _searchPage(pageKey);
      }
    });
  }

  Future<void> _searchPage(int pageKey) async {
    try {
      final searchResults = await ForumService.searchQuestions(
        _searchQuery,
        pageKey,
        _pageSize,
      );

      final isLastPage = searchResults.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(searchResults);
      } else {
        final nextPage = pageKey + 1;
        _pagingController.appendPage(searchResults, nextPage);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  // Function to update the search query and refresh the list
  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
      _pagingController.refresh();
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
        actions: [
          // Add a search bar in the app bar
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ForumSearchDelegate(_updateSearchQuery),
              );
            },
          ),
        ],
      ),
      drawer: const ForumDrawer(),
      body: PagedListView<int, ForumQuestion>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ForumQuestion>(
          itemBuilder: (context, question, index) =>
              ForumQuestionCard(question: question),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddForumQuestionView()));
          },
          child: const Icon(Icons.add)),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
