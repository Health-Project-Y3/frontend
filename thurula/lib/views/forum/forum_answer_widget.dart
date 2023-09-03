import 'package:flutter/material.dart';

import '../../models/forum_question_model.dart';

class ForumAnswerCard extends StatefulWidget {
  final ForumAnswer answer;

  ForumAnswerCard({required this.answer});

  @override
  _ForumAnswerCardState createState() => _ForumAnswerCardState();
}

class _ForumAnswerCardState extends State<ForumAnswerCard> {
  int upvotes = 0;
  int downvotes = 0;

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
            // Add more answer details as needed
          ],
        ),
      ),
    );
  }
}
