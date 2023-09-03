import 'package:flutter/material.dart';

import '../../models/forum_question_model.dart';
import 'forum_answers..dart';

class ForumQuestionCard extends StatefulWidget {
  final ForumQuestion question;

  ForumQuestionCard({required this.question});

  @override
  _ForumQuestionCardState createState() => _ForumQuestionCardState();
}

class _ForumQuestionCardState extends State<ForumQuestionCard> {
  int upvotes = 0;
  int downvotes = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(widget.question.question ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Posted by: ${'${widget.question.authorFirstName} ${widget.question.authorLastName}'}'),
              Text('Date Posted: ${ForumQuestion.getDate(widget.question.date!)}'),
              Text(widget.question.description ?? ''),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    onPressed: () {
                      setState(() {
                        upvotes++;
                      });
                      // Add your upvote logic here
                    },
                  ),
                  const SizedBox(width: 4),
                  Text('$upvotes'),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.thumb_down),
                    onPressed: () {
                      setState(() {
                        downvotes++;
                      });
                      // Add your downvote logic here
                    },
                  ),
                  const SizedBox(width: 4),
                  Text('$downvotes'),
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
            builder: (context) => ForumAnswersView(questionId: widget.question.id!),
          ),
        );
      },
    );
  }
}
