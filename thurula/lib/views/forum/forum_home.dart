import 'package:flutter/material.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/forum/forum_answers..dart';
import '../../models/forum_question_model.dart';
import 'dart:async';

class ForumHomeView extends StatefulWidget {
  const ForumHomeView({Key? key}) : super(key: key);

  @override
  State<ForumHomeView> createState() => _ForumHomeViewState();
}

class _ForumHomeViewState extends State<ForumHomeView> {
  Future<List<ForumQuestion>>? _futureQuestions;

  @override
  void initState() {
    super.initState();
    _futureQuestions = ForumService.getRecentQuestions(
        1, 10); // Change page and pageSize as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Forum Questions'),
      ),
      body: FutureBuilder<List<ForumQuestion>>(
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
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];

                return GestureDetector(
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(question.question ?? ''),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Posted by: ${'${question.authorFirstName} ${question.authorLastName}'}'),
                            Text(
                                'Date Posted: ${ForumQuestion.getDate(question.date!)}'),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ForumAnswersView(questionId: question.id!),
                        ),
                      );
                    });
              },
            );
          }
        },
      ),
    );
  }
}
