import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/forum/forum_answer_widget.dart';
import 'package:thurula/views/forum/forum_question_widget.dart';
import 'package:thurula/views/widgets/toast_widget.dart';
import '../../models/forum_question_model.dart';
import 'dart:async';

import '../../providers/user_provider.dart';
import 'forum_answer_input_widget.dart';

class ForumAnswersView extends StatefulWidget {
  final String questionId;

  const ForumAnswersView({Key? key, required this.questionId}) : super(key: key);

  @override
  State<ForumAnswersView> createState() => _ForumAnswersViewState();
}

class _ForumAnswersViewState extends State<ForumAnswersView> {
  Future<ForumQuestion>? _futureQuestion;

  @override
  void initState() {
    super.initState();
    _futureQuestion = ForumService.getQuestion(widget.questionId);
  }

  // Function to handle answer submission
  void _handleAnswerSubmitted(String answerText) async {
    try {
      var newAnswer = ForumAnswer(
        questionId: widget.questionId,
        answer: answerText,
        author: context.read<UserProvider>().user?.id ?? '',
        authorFirstName: context.read<UserProvider>().user?.fname ?? '',
        authorLastName: context.read<UserProvider>().user?.lname ?? '',
        date: DateTime.now(),
        accepted: false,
        upvotes: 0,
        downvotes: 0,
      );
      newAnswer = await ForumService.addAnswer(widget.questionId, newAnswer);

      setState(() {
        // Update the ForumQuestion object with the new answer
        _futureQuestion = Future.value(_futureQuestion!.then((question) {
          question.answers!.insert(0,newAnswer);

          //show toast
          GFToast.showToast(
            'Answer submitted successfully',
            context,
            toastPosition: GFToastPosition.BOTTOM,
            toastDuration: 3,
            backgroundColor: Colors.green,
          );

          return question;
        }));
      });
    } catch (error) {
      log('Error submitting answer: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum Question and Answers'),
      ),
      body: FutureBuilder<ForumQuestion>(
        future: _futureQuestion,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available.'),
            );
          } else {
            final question = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ForumQuestionCard(
                          question: question, allowRedirect: false),
                      // Display answers here
                      ...question.answers
                              ?.map((answer) => ForumAnswerCard(
                                  answer: answer, questionId: question.id!))
                              .toList() ??
                          []
                    ],
                  ),
                ),
                ForumAnswerInput(
                  onAnswerSubmitted: (answerText) {
                    _handleAnswerSubmitted(answerText);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

}
