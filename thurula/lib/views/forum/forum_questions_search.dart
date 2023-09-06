import 'package:flutter/material.dart';

import '../../models/forum_question_model.dart';
import '../../services/forum_service.dart';
import 'forum_question_widget.dart';

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
