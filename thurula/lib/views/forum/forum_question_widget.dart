import 'package:flutter/material.dart';

import '../../models/forum_question_model.dart';
import '../../services/forum_service.dart';
import 'forum_answers_view.dart';

class ForumQuestionCard extends StatefulWidget {
  final ForumQuestion question;
  final bool allowRedirect;


  const ForumQuestionCard({
    super.key,
    required this.question,
    this.allowRedirect = true,
  });

  @override
  _ForumQuestionCardState createState() => _ForumQuestionCardState();
}

class _ForumQuestionCardState extends State<ForumQuestionCard> {
  static const QUESTION_LENGTH = 100; // The number of characters to show before truncating
  static const DESCRIPTION_LENGTH = 100; // The number of characters to show before truncating
  late int upvotes = 0;
  late int downvotes = 0;
  bool hasUpvoted = false; // Track if upvote button is clicked
  bool hasDownvoted = false; // Track if downvote button is clicked

  @override
  void initState() {
    super.initState();
    // Initialize upvotes and downvotes with values from the ForumQuestion object
    upvotes = widget.question.upvotes ?? 0;
    downvotes = widget.question.downvotes ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 1, // Add elevation for a card-like appearance
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding for spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //a circle avatar with the first letter of the first and last name of the author
                  CircleAvatar(
                    child: Text(
                      '${widget.question.authorFirstName?[0]}${widget.question.authorLastName?[0]}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.question.authorFirstName} ${widget.question.authorLastName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    getDate(widget.question),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                getQuestion(widget.question),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Increase font size for the question
                ),
              ),
              const SizedBox(height: 8),
              Text(
                getDescription(widget.question),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                //left align
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_upward,
                          size: 24,
                        ),
                        color: hasUpvoted ? Colors.green : Colors.grey,
                        onPressed: () {
                          setState(() {
                            if (hasUpvoted) {
                              hasUpvoted = false;
                              upvotes--;
                              ForumService.upvoteQuestion(widget.question.id!,
                                  undo: true);
                            } else if (hasDownvoted) {
                              upvotes++;
                              downvotes--;
                              hasDownvoted = false;
                              hasUpvoted = true;
                              ForumService.switchvoteQuestion(
                                  widget.question.id!, true);
                            } else {
                              hasUpvoted = true;
                              upvotes++;
                              ForumService.upvoteQuestion(widget.question.id!);
                            }
                          });
                        },
                      ),
                      Text(
                        '$upvotes',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_downward,
                          size: 24,
                        ),
                        color: hasDownvoted ? Colors.red : Colors.grey,
                        onPressed: () {
                          setState(() {
                            if (hasDownvoted) {
                              hasDownvoted = false;
                              downvotes--;
                              ForumService.downvoteQuestion(widget.question.id!,
                                  undo: true);
                            } else if (hasUpvoted) {
                              downvotes++;
                              upvotes--;
                              hasUpvoted = false;
                              hasDownvoted = true;
                              ForumService.switchvoteQuestion(
                                  widget.question.id!, false);
                            } else {
                              hasDownvoted = true;
                              downvotes++;
                              ForumService.downvoteQuestion(
                                  widget.question.id!);
                            }
                          });
                        },
                      ),
                      Text(
                        '$downvotes',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.message,
                        size: 24,
                      ),
                      Text(
                        '${widget.question.answers?.length ?? 0}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (!widget.allowRedirect) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ForumAnswersView(questionId: widget.question.id!),
          ),
        );
      },
    );
  }

  String getDate(ForumQuestion question) {
    final now = DateTime.now();
    final difference = now.difference(question.date!);

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

  String getQuestion(ForumQuestion question) {
    //truncate the question if it is too long
    if (question.question!.length > QUESTION_LENGTH) {
      return '${question.question!.substring(0, QUESTION_LENGTH)}...';
    } else {
      return question.question!;
    }
  }
  String getDescription(ForumQuestion question) {
    //truncate the description if it is too long
    if (question.description!.length > DESCRIPTION_LENGTH) {
      return '${question.description!.substring(0, DESCRIPTION_LENGTH)}...';
    } else {
      return question.description!;
    }
  }
}
