import 'package:flutter/material.dart';

class ForumAnswerInput extends StatefulWidget {
  final Function(String) onAnswerSubmitted;

  const ForumAnswerInput({Key? key, required this.onAnswerSubmitted}) : super(key: key);

  @override
  _ForumAnswerInputState createState() => _ForumAnswerInputState();
}

class _ForumAnswerInputState extends State<ForumAnswerInput> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                hintText: 'Type your answer...',
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final answerText = _answerController.text;
              if (answerText.isNotEmpty) {
                widget.onAnswerSubmitted(answerText); // Call the callback function to submit the answer
                _answerController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
