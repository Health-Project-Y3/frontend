import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/forum/forum_drawer_widget.dart';
import 'package:thurula/views/forum/forum_question_widget.dart';
import 'package:thurula/views/widgets/navbar_widget.dart';
import '../../models/forum_question_model.dart';
import 'forum_question_add_view.dart';
import 'forum_questions_search.dart';

class ForumHomeView extends StatefulWidget {
  const ForumHomeView({Key? key}) : super(key: key);

  @override
  State<ForumHomeView> createState() => _ForumHomeViewState();
}

class _ForumHomeViewState extends State<ForumHomeView> {
  String _searchQuery = '';
  static const _pageSize = 10;
  late PagingController<int, ForumQuestion> _pagingController =
      PagingController(
          firstPageKey: 1, invisibleItemsThreshold: (_pageSize / 4).round());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

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
  // Implement the refresh logic here
  Future<void> _refresh() async {
    // Dispose the current paging controller
    _pagingController.dispose();

    // Create a new paging controller with the initial settings
    final newController = PagingController<int, ForumQuestion>(
      firstPageKey: 1,
      invisibleItemsThreshold: (_pageSize / 4).round(),
    );

    // Add the page request listener to the new controller
    newController.addPageRequestListener((pageKey) {
      if (_searchQuery.isEmpty) {
        _fetchPage(pageKey);
      } else {
        _searchPage(pageKey);
      }
    });

    setState(() {
      // Update the paging controller with the new one
      _pagingController = newController;
    });

    // Fetch the first page of data
    await _fetchPage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: ()async{
          await _refresh();
        },
        child: PagedListView<int, ForumQuestion>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<ForumQuestion>(
            itemBuilder: (context, question, index) =>
                ForumQuestionCard(question: question),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddForumQuestionView()));
          },
          child: const Icon(Icons.add)),
      bottomNavigationBar: const CreateBottomNavigationBar(pageIndex: 0),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

