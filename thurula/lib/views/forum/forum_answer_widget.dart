import 'package:flutter/material.dart';
import 'package:thurula/services/forum_service.dart';

import '../../models/forum_question_model.dart';

class ForumAnswerCard extends StatefulWidget {
  final ForumAnswer answer;
  final String questionId;

  const ForumAnswerCard(
      {super.key, required this.answer, required this.questionId});

  @override
  _ForumAnswerCardState createState() => _ForumAnswerCardState();
}

class _ForumAnswerCardState extends State<ForumAnswerCard> {
  late int upvotes = 0;
  late int downvotes = 0;
  bool hasUpvoted = false; // Track if upvote button is clicked
  bool hasDownvoted = false; // Track if downvote button is clicked
  bool isExpanded = false; // Track if the answer is expanded
  static const ANSWER_LENGTH = 100; // The number of characters to show before truncating

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              isExpanded
                  ? widget.answer.answer ?? ''
                  : _truncateText(widget.answer.answer ?? ''),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Answered by: ${'${widget.answer.authorFirstName} ${widget.answer.authorLastName}'}'),
                Text('Date Answered: ${getDate(widget.answer)}'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      color: hasUpvoted ? Colors.green : Colors.grey,
                      onPressed: () {
                        setState(() {
                          if (hasUpvoted) {
                            hasUpvoted = false;
                            upvotes--;
                            ForumService.upvoteAnswer(
                                widget.questionId, widget.answer.id!,
                                undo: true);
                          } else if (hasDownvoted) {
                            upvotes++;
                            downvotes--;
                            hasDownvoted = false;
                            hasUpvoted = true;
                            ForumService.switchVoteAnswer(
                                widget.questionId, widget.answer.id!, true);
                          } else {
                            hasUpvoted = true;
                            upvotes++;
                            ForumService.upvoteAnswer(
                                widget.questionId, widget.answer.id!);
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 4),
                    Text('$upvotes'),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      color: hasDownvoted ? Colors.red : Colors.grey,
                      onPressed: () {
                        setState(() {
                          if (hasDownvoted) {
                            hasDownvoted = false;
                            downvotes--;
                            ForumService.downvoteAnswer(
                                widget.questionId, widget.answer.id!,
                                undo: true);
                          } else if (hasUpvoted) {
                            downvotes++;
                            upvotes--;
                            hasUpvoted = false;
                            hasDownvoted = true;
                            ForumService.switchVoteAnswer(
                                widget.questionId, widget.answer.id!, false);
                          } else {
                            hasDownvoted = true;
                            downvotes++;
                            ForumService.downvoteAnswer(
                                widget.questionId, widget.answer.id!);
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 4),
                    Text('$downvotes'),
                  ],
                ),
                if (!isExpanded && widget.answer.answer!.length > ANSWER_LENGTH)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = true;
                          });
                        },
                        child: const Text('Show more'),
                      ),
                    ],
                  ),
                // Add more answer details as needed
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = false;
                      });
                    },
                    child: const Text('Show less'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _truncateText(String text) {
    if (text.length <= ANSWER_LENGTH) {
      return text;
    }
    return '${text.substring(0, ANSWER_LENGTH)}...';
  }

  String getDate(ForumAnswer answer) {
    var date = answer.date!;
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 14) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }
}
