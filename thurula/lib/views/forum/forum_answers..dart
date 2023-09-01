import 'package:flutter/material.dart';
import 'package:thurula/services/forum_service.dart';
import '../../models/forum_question_model.dart';
import 'dart:async';

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
            return ListView(
              children: [
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(question.question ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Posted by: ${'${question.authorFirstName} ${question.authorLastName}'}'),
                        Text('Date Posted: ${ForumQuestion.getDate(question.date!)}'),
                        Text(question.description ?? ''),
                        Row(
                          children: [
                            const Icon(Icons.thumb_up),
                            const SizedBox(width: 4),
                            // Add some spacing
                            Text('${question.upvotes}'),
                            // Replace 'upvotes' with your property
                            const SizedBox(width: 16),
                            // Add spacing between the icons
                            const Icon(Icons.thumb_down),
                            const SizedBox(width: 4),
                            // Add some spacing
                            Text('${question.downvotes}'),
                            // Replace 'downvotes' with your property
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Display answers here
                ...?question.answers?.map((answer) => Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(answer.answer ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Answered by: ${'${answer.authorFirstName} ${answer.authorLastName}'}'),
                        Text('Date Answered: ${ForumQuestion.getDate(answer.date!)}'),
                        Row(
                          children: [
                            const Icon(Icons.thumb_up),
                            const SizedBox(width: 4),
                            // Add some spacing
                            Text('${question.upvotes}'),
                            // Replace 'upvotes' with your property
                            const SizedBox(width: 16),
                            // Add spacing between the icons
                            const Icon(Icons.thumb_down),
                            const SizedBox(width: 4),
                            // Add some spacing
                            Text('${question.downvotes}'),
                            // Replace 'downvotes' with your property
                          ],
                        ),

                        // Add more answer details as needed
                      ],
                    ),
                  ),
                )).toList(),
              ],
            );
          }
        },
      ),
    );
  }
}
