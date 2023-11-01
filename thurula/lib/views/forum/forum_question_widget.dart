import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/providers/user_provider.dart';
import 'package:thurula/views/widgets/toast_widget.dart';

import '../../models/forum_question_model.dart';
import '../../services/forum_service.dart';
import 'forum_answers_view.dart';

class ForumQuestionCard extends StatefulWidget {
  final ForumQuestion question;
  final bool allowRedirect;
  final bool trash;

  const ForumQuestionCard({
    super.key,
    required this.question,
    this.allowRedirect = true,
    this.trash = false,
  });

  @override
  _ForumQuestionCardState createState() => _ForumQuestionCardState();
}

class _ForumQuestionCardState extends State<ForumQuestionCard> {
  bool _isDeleted = false;
  bool _isReported = false;
  static const QUESTION_LENGTH =
      100; // The number of characters to show before truncating
  static const DESCRIPTION_LENGTH =
      100; // The number of characters to show before truncating
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
    if (_isDeleted || _isReported) {
      // If the card is deleted, return an AnimatedSize widget to smoothly animate its size change.
      return const SizedBox(
        height: 0,
        width: double.infinity,
      );
    }
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
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 17.0,
                        //add a random background color
                        backgroundColor: Colors.primaries[
                            widget.question.authorFirstName![0].codeUnitAt(0) %
                                Colors.primaries.length],
                        child: Text(
                          '${widget.question.authorFirstName?[0]}${widget.question.authorLastName?[0]}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${widget.question.authorFirstName} ${widget.question.authorLastName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    getDate(widget.question),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      if (!shouldShowTrashIcon())
                        PopupMenuItem(
                          onTap: () {
                            showReportConfirmationDialog(context);
                          },
                          value: 'report',
                          child: const Text('Report'),
                        ),
                      if (shouldShowTrashIcon())
                        PopupMenuItem(
                          onTap: () {
                            showDeleteConfirmationDialog(context);
                          },
                          value: 'delete',
                          child: const Text('Delete'),
                        ),
                    ],
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
              const SizedBox(height: 8),
              Row(
                //left align
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                                  ForumService.upvoteQuestion(
                                      widget.question.id!,
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
                                  ForumService.upvoteQuestion(
                                      widget.question.id!);
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
                                  ForumService.downvoteQuestion(
                                      widget.question.id!,
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
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 14) {
      return '1 week ago';
    } else if (difference.inDays < 30) {
      final weeks = difference.inDays ~/ 7;
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
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

  // Function to check if the trash icon should be displayed
  bool shouldShowTrashIcon() {
    //check if the user is the author of the question
    if (widget.question.authorId == context.read<UserProvider>().user?.id) {
      return true;
    } else {
      return false;
    }
  }

  // Function to show a delete confirmation dialog
  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Are you sure you want to delete this question?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isDeleted = true;
                });
                Navigator.of(context).pop(true);
                ForumService.deleteQuestion(widget.question.id!);
                GFToast.showToast(
                  'Question deleted',
                  context,
                  toastPosition: GFToastPosition.BOTTOM,
                  backgroundColor: Colors.green,
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  //Function to show report confirmation dialog
  Future<void> showReportConfirmationDialog(BuildContext context) async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Are you sure you want to report this question?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isReported = true;
                });
                Navigator.of(context).pop(true);
                GFToast.showToast(
                  'Question reported',
                  context,
                  toastPosition: GFToastPosition.BOTTOM,
                  backgroundColor: Colors.green,
                );
              },
              child: const Text('Report'),
            ),
          ],
        );
      },
    );
  }
}
