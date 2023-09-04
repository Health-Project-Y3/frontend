import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/services/forum_service.dart';
import 'package:thurula/views/widgets/toast_widget.dart';

import '../../models/forum_question_model.dart';
import '../../providers/user_provider.dart';

class AddForumQuestionView extends StatefulWidget {
  const AddForumQuestionView({super.key});

  @override
  _AddForumQuestionViewState createState() => _AddForumQuestionViewState();
}

class _AddForumQuestionViewState extends State<AddForumQuestionView> {
  final _formKey = GlobalKey<FormState>();
  final ForumQuestion _question = ForumQuestion();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a New Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
                onSaved: (value) {
                  _question.question = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                onSaved: (value) {
                  _question.description = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Keywords (comma-separated)'),
                onSaved: (value) {
                  _question.keywords = value?.split(',').map((e) => e.trim()).toList();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var question = ForumQuestion(
                      question: _question.question,
                      description: _question.description,
                      keywords: _question.keywords,
                      authorId: context.read<UserProvider>().user?.id ?? '',
                      authorFirstName:  context.read<UserProvider>().user?.fname ?? '',
                      authorLastName:  context.read<UserProvider>().user?.lname ?? '',
                      date: DateTime.now(),
                      upvotes: 0,
                      downvotes: 0,
                      visible: true,
                      answers: [],
                    );
                    ForumService.addQuestion(question);
                    Navigator.pop(context);
                    GFToast.showToast(
                      'Question posted successfully',
                      context,
                      toastPosition: GFToastPosition.BOTTOM,
                      toastDuration: 3,
                      backgroundColor: Colors.green,
                    );

                    // Reset the form
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text('Post Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
