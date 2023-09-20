class ForumQuestion {
  String? id;
  String? question;
  String? description;
  String? authorId;
  String? authorFirstName;
  String? authorLastName;
  DateTime? date;
  List<String>? keywords;
  bool? visible;
  int? upvotes;
  int? downvotes;
  List<ForumAnswer>? answers;

  ForumQuestion({
    this.id,
    this.question,
    this.description,
    this.authorId,
    this.authorFirstName,
    this.authorLastName,
    this.date,
    this.keywords,
    this.visible,
    this.upvotes,
    this.downvotes,
    this.answers,
  });

  static Map<String, dynamic> toJson(ForumQuestion question) {
    return {
      'question': question.question,
      'description': question.description,
      'authorId': question.authorId,
      'authorFirstName': question.authorFirstName,
      'authorLastName': question.authorLastName,
      'date': question.date?.toIso8601String(),
      'keywords': question.keywords,
      'visible': question.visible,
      'upvotes': question.upvotes,
      'downvotes': question.downvotes,
      'answers': [
        for (var answer in question.answers!)
          {
            'questionId': answer.questionId,
            'answer': answer.answer,
            'author': answer.author,
            'authorFirstName': answer.authorFirstName,
            'authorLastName': answer.authorLastName,
            'date': answer.date?.toIso8601String(),
            'accepted': answer.accepted,
            'upvotes': answer.upvotes,
            'downvotes': answer.downvotes,
          }
      ]
    };
  }

  static ForumQuestion fromJson(jsonDecode) {
    return ForumQuestion(
      id: jsonDecode['id'],
      question: jsonDecode['question'],
      description: jsonDecode['description'],
      authorId: jsonDecode['authorId'],
      authorFirstName: jsonDecode['authorFirstName'],
      authorLastName: jsonDecode['authorLastName'],
      date: DateTime.parse(jsonDecode['date']),
      keywords: jsonDecode['keywords'].cast<String>(),
      visible: jsonDecode['visible'] == 1,
      upvotes: jsonDecode['upvotes'],
      downvotes: jsonDecode['downvotes'],
      answers: jsonDecode['answers']
          .map<ForumAnswer>((answer) => ForumAnswer.fromJson(answer))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ForumQuestion{id: $id, question: $question, description: $description, authorId: $authorId, authorFirstName: $authorFirstName, authorLastName: $authorLastName, date: $date, keywords: $keywords, visible: $visible, upvotes: $upvotes, downvotes: $downvotes, answers: $answers}';
  }
}

class ForumAnswer {
  String? id;
  String? questionId;
  String? answer;
  String? author;
  String? authorFirstName;
  String? authorLastName;
  DateTime? date;
  bool? accepted;
  int? upvotes;
  int? downvotes;

  ForumAnswer({
    this.id,
    this.questionId,
    this.answer,
    this.author,
    this.authorFirstName,
    this.authorLastName,
    this.date,
    this.accepted,
    this.upvotes,
    this.downvotes,
  });

  static Map<String, dynamic> toJson(ForumAnswer answer) {
    return {
      'questionId': answer.questionId,
      'answer': answer.answer,
      'author': answer.author,
      'authorFirstName': answer.authorFirstName,
      'authorLastName': answer.authorLastName,
      'date': answer.date?.toIso8601String(),
      'accepted': answer.accepted,
      'upvotes': answer.upvotes,
      'downvotes': answer.downvotes,
    };
  }

  static ForumAnswer fromJson(jsonDecode) {
    return ForumAnswer(
      id: jsonDecode['id'],
      questionId: jsonDecode['questionId'],
      answer: jsonDecode['answer'],
      author: jsonDecode['author'],
      authorFirstName: jsonDecode['authorFirstName'],
      authorLastName: jsonDecode['authorLastName'],
      date: DateTime.parse(jsonDecode['date']),
      accepted: jsonDecode['accepted'] == 1,
      upvotes: jsonDecode['upvotes'],
      downvotes: jsonDecode['downvotes'],
    );
  }

  static String getDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 14) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      return '${difference.inDays ~/ 30} months ago';
    } else {
      return '${difference.inDays ~/ 365} years ago';
    }
  }

  @override
  String toString() {
    return 'ForumAnswer{id: $id, questionId: $questionId, answer: $answer, author: $author, authorFirstName: $authorFirstName, authorLastName: $authorLastName, date: $date, accepted: $accepted, upvotes: $upvotes, downvotes: $downvotes}';
  }
}
