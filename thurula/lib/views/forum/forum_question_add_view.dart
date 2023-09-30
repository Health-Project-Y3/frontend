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
  List<String> selectedKeywords = []; // List to store selected keywords

  // Predefined list of keywords
  final List<String> predefinedKeywords = [
    'Health',
    'Education',
    'Nutrition',
    'Pregnancy'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                maxLines: 4,
                onSaved: (value) {
                  _question.description = value;
                },
              ),
              const SizedBox(height: 20),
              const Text('Keywords'),
              const SizedBox(height: 10),
              // Display selected keywords as chips
              Wrap(
                children: predefinedKeywords.map((keyword) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    child: FilterChip(
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          keyword,
                          style: TextStyle(
                            color: selectedKeywords.contains(keyword)
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                      ),
                      selected: selectedKeywords.contains(keyword),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            selectedKeywords.add(keyword);
                          } else {
                            selectedKeywords.remove(keyword);
                          }
                        });
                      },
                      backgroundColor: selectedKeywords.contains(keyword)
                          ? const Color.fromARGB(255, 88, 119, 161)
                          : Colors.grey,
                      selectedColor: const Color.fromARGB(255, 88, 119, 161), // Change to the color you want for selected chips
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 220, 104, 145),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Add the selected keywords to the question
                    _question.keywords = selectedKeywords;
                    var question = ForumQuestion(
                      question: _question.question,
                      description: _question.description,
                      keywords: _question.keywords,
                      authorId: context.read<UserProvider>().user?.id ?? '',
                      authorFirstName:
                          context.read<UserProvider>().user?.fname ?? '',
                      authorLastName:
                          context.read<UserProvider>().user?.lname ?? '',
                      date: DateTime.now(),
                      upvotes: 0,
                      downvotes: 0,
                      visible: true,
                      answers: [],
                    );
                    ForumService.addQuestion(question);
                    GFToast.showToast(
                      'Question posted successfully',
                      context,
                      toastPosition: GFToastPosition.BOTTOM,
                      toastDuration: 3,
                      backgroundColor: Colors.green,
                    );

                    // Reset the form
                    _formKey.currentState!.reset();
                    Navigator.pop(context);
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
