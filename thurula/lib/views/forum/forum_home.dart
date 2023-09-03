import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/forum/forum_question_widget.dart';
import '../../models/forum_question_model.dart';
import 'dart:async';

class ForumHomeView extends StatefulWidget {
  const ForumHomeView({Key? key}) : super(key: key);

  @override
  State<ForumHomeView> createState() => _ForumHomeViewState();
}

class _ForumHomeViewState extends State<ForumHomeView> {
  Future<List<ForumQuestion>>? _futureQuestions;
  bool _reachedEndOfData = false;
  var pageNumber = 1;
  final _pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  List<ForumQuestion> existingQuestions = [];

  void _scrollListener() {
    if (!_reachedEndOfData &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list, load more questions
      _loadMoreQuestions();
    }
  }

  void _loadMoreQuestions() {
    // Fetch the next page of questions and append them to the existing list
    final nextPage = _futureQuestions!.then((existingQuestions) {
      final nextPageNumber = (existingQuestions.length / _pageSize).ceil() + 1;
      log("Next PageNumber : $nextPageNumber");
      return ForumService.getRecentQuestions(nextPageNumber, _pageSize);
    });

    nextPage.then((nextPageQuestions) {
      setState(() {
        if (nextPageQuestions.isEmpty) {
          // No more data available
          _reachedEndOfData = true;
        } else {
          // Append the new questions to the existing list
          existingQuestions.addAll(nextPageQuestions);
          _reachedEndOfData = false;
        }
        _futureQuestions = Future.value(existingQuestions);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _futureQuestions = ForumService.getRecentQuestions(
        1, _pageSize); // Change page and pageSize as needed
    //also add to existingQuestions
    _futureQuestions!.then((questions) {
      existingQuestions.addAll(questions);
    });
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Forum Questions'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ForumQuestion>>(
              future: _futureQuestions,
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
                  return const Center(
                    child: Text('No recent questions available.'),
                  );
                } else {
                  final questions = snapshot.data!;

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: questions.length + (_reachedEndOfData ? 1 : 0),
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return ForumQuestionCard(question: question);
                    },
                  );
                }
              },
            ),
          ),
          if (_reachedEndOfData)
            // Optionally, you can display a button or other UI elements here
            // to allow the user to reload the list or perform some other action
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the action to reload or do something else
                },
                child: const Text('Reload Questions'),
              ),
            ),
        ],
      ),
    );
  }
}
