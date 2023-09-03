import 'package:flutter/material.dart';

import '../../models/forum_question_model.dart';
import '../../services/forum_service.dart';
import 'forum_answers..dart';

class ForumQuestionCard extends StatefulWidget {
  final ForumQuestion question;

  ForumQuestionCard({required this.question});

  @override
  _ForumQuestionCardState createState() => _ForumQuestionCardState();
}

class _ForumQuestionCardState extends State<ForumQuestionCard> {
  late int upvotes = 0;
  late int downvotes = 0;
  bool hasUpvoted = false; // Track if upvote button is clicked
  bool hasDownvoted = false; // Track if downvote button is clicked

  @override
  void initState() {
    super.initState();
    // Initialize upvotes and downvotes with values from the ForumQuestion object
    upvotes = widget.question.upvotes!;
    downvotes = widget.question.downvotes!;
  }

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
                    color: hasUpvoted ? Colors.green : Colors.grey,
                    onPressed: () {
                      setState(() {
                        if (hasUpvoted) {
                          hasUpvoted = false;
                          upvotes--;
                          ForumService.upvoteQuestion(widget.question.id!, undo: true);
                        } else if (hasDownvoted) {
                          upvotes++;
                          downvotes--;
                          hasDownvoted = false;
                          hasUpvoted = true;
                          ForumService.upvoteQuestion(widget.question.id!);
                          ForumService.downvoteQuestion(widget.question.id!, undo: true);
                        } else {
                          hasUpvoted = true;
                          upvotes++;
                          ForumService.upvoteQuestion(widget.question.id!);
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 4),
                  Text('$upvotes'),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.thumb_down),
                    color: hasDownvoted ? Colors.red : null,
                    onPressed: () {
                      setState(() {
                        if (hasDownvoted) {
                          hasDownvoted = false;
                          downvotes--;
                          ForumService.downvoteQuestion(widget.question.id!, undo: true);
                        } else if (hasUpvoted) {
                          downvotes++;
                          upvotes--;
                          hasUpvoted = false;
                          hasDownvoted = true;
                          ForumService.upvoteQuestion(widget.question.id!, undo: true);
                          ForumService.downvoteQuestion(widget.question.id!);
                        } else {
                          hasDownvoted = true;
                          downvotes++;
                          ForumService.downvoteQuestion(widget.question.id!);
                        }
                      });
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
