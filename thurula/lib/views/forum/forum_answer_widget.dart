import 'package:flutter/material.dart';
import 'package:thurula/services/forum_service.dart';

import '../../models/forum_question_model.dart';

class ForumAnswerCard extends StatefulWidget {
  final ForumAnswer answer;
  late final String questionId;

  ForumAnswerCard({required this.answer, required this.questionId});

  @override
  _ForumAnswerCardState createState() => _ForumAnswerCardState();
}

class _ForumAnswerCardState extends State<ForumAnswerCard> {
  late int upvotes = 0;
  late int downvotes = 0;
  bool hasUpvoted = false; // Track if upvote button is clicked
  bool hasDownvoted = false; // Track if downvote button is clicked

  @override
  void initState() {
    super.initState();
    // Initialize upvotes and downvotes with values from the ForumAnswer object
    upvotes = widget.answer.upvotes!;
    downvotes = widget.answer.downvotes!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(widget.answer.answer ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Answered by: ${'${widget.answer.authorFirstName} ${widget.answer.authorLastName}'}'),
            Text('Date Answered: ${ForumQuestion.getDate(widget.answer.date!)}'),
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
                        ForumService.upvoteAnswer(widget.questionId, widget.answer.id!, undo: true);
                      } else if (hasDownvoted) {
                        upvotes++;
                        downvotes--;
                        hasDownvoted = false;
                        hasUpvoted = true;
                        ForumService.upvoteAnswer(widget.questionId, widget.answer.id!);
                        ForumService.downvoteAnswer(widget.questionId, widget.answer.id!, undo: true);
                      } else {
                        hasUpvoted = true;
                        upvotes++;
                        ForumService.upvoteAnswer(widget.questionId, widget.answer.id!);
                      }
                    });
                  },
                ),
                const SizedBox(width: 4),
                Text('$upvotes'),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.thumb_down),
                  color: hasDownvoted ? Colors.red : Colors.grey,
                  onPressed: () {
                    setState(() {
                      if (hasDownvoted) {
                        hasDownvoted = false;
                        downvotes--;
                        ForumService.downvoteAnswer(widget.questionId, widget.answer.id!, undo: true);
                      } else if (hasUpvoted) {
                        downvotes++;
                        upvotes--;
                        hasUpvoted = false;
                        hasDownvoted = true;
                        ForumService.upvoteAnswer(widget.questionId, widget.answer.id!, undo: true);
                        ForumService.downvoteAnswer(widget.questionId, widget.answer.id!);
                      } else {
                        hasDownvoted = true;
                        downvotes++;
                        ForumService.downvoteAnswer(widget.questionId, widget.answer.id!);
                      }
                    });
                  },
                ),
                const SizedBox(width: 4),
                Text('$downvotes'),
              ],
            ),
            // Add more answer details as needed
          ],
        ),
      ),
    );
  }
}
