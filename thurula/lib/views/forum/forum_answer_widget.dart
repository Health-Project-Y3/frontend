import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/services/forum_service.dart';

import '../../models/forum_question_model.dart';
import '../../providers/user_provider.dart';
import '../widgets/toast_widget.dart';

class ForumAnswerCard extends StatefulWidget {
  final ForumAnswer answer;
  final String questionId;

  const ForumAnswerCard(
      {super.key, required this.answer, required this.questionId});

  @override
  _ForumAnswerCardState createState() => _ForumAnswerCardState();
}

class _ForumAnswerCardState extends State<ForumAnswerCard> {
  bool _isDeleted = false;
  bool _isReported = false;
  late int upvotes = 0;
  late int downvotes = 0;
  bool hasUpvoted = false; // Track if upvote button is clicked
  bool hasDownvoted = false; // Track if downvote button is clicked
  bool isExpanded = false; // Track if the answer is expanded
  static const ANSWER_LENGTH =
      100; // The number of characters to show before truncating

  @override
  void initState() {
    super.initState();
    // Initialize upvotes and downvotes with values from the ForumAnswer object
    upvotes = widget.answer.upvotes!;
    downvotes = widget.answer.downvotes!;
  }

  @override
  Widget build(BuildContext context) {
    if (_isReported || _isDeleted) {
      return const SizedBox.shrink();
    }
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
                    'Answered by ${'${widget.answer.authorFirstName} ${widget.answer.authorLastName} ${getDate(widget.answer)}'}'),

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
                    const Spacer(),
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

  // Function to show a delete confirmation dialog
  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Are you sure you want to delete this answer?'),
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
                ForumService.deleteAnswer(widget.questionId, widget.answer.id!);
                GFToast.showToast(
                  'Answer deleted',
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
          content: const Text('Are you sure you want to report this answer?'),
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
                  'Answer reported',
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

  // Function to check if the trash icon should be displayed
  bool shouldShowTrashIcon() {
    //check if the user is the author of the question
    if (widget.answer.author == context.read<UserProvider>().user?.id) {
      return true;
    } else {
      return false;
    }
  }
}
