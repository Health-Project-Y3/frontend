import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/forum/forum_question_widget.dart';
import '../../models/forum_question_model.dart';
import 'forum_add_question_view.dart';

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

class ForumSearchDelegate extends SearchDelegate<String> {
  final Function(String) onSearchQueryChanged;

  ForumSearchDelegate(this.onSearchQueryChanged);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearchQueryChanged(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Please enter a search query.'),
      );
    }
    return FutureBuilder<List<ForumQuestion>>(
      // Replace this Future with your search function
      future: ForumService.searchQuestions(query, 1, 100),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No results found for: $query'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final question = snapshot.data?[index];
              return ForumQuestionCard(question: question!);
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Please enter a search query.'),
      );
    }
    return FutureBuilder<List<ForumQuestion>>(
      // Replace with your actual search function that fetches results dynamically based on the query
      future: ForumService.searchQuestions(query,1,100),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No results found for: $query'),
          );
        } else {
          final searchResults = snapshot.data;

          return ListView.builder(
            itemCount: searchResults?.length,
            itemBuilder: (context, index) {
              final question = searchResults?[index];
              return ListTile(
                title: Text(question!.question!), // Replace with the appropriate property of ForumQuestion
                //show truncated question description
                subtitle: Text(question.description != null
                    ? (question.description!.length > 100
                    ? '${question.description!.substring(0, 100)}...'
                    : question.description!)
                    : '',), // Replace with the appropriate property of ForumQuestion
                onTap: () {
                  query = question.question!; // Set the query to the selected suggestion
                  showResults(context); // Show the search results
                },
              );
            },
          );
        }
      },
    );
  }

}
