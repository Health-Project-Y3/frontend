import 'dart:convert';

import '../constants/routes.dart';
import '../models/forum_question_model.dart';
import 'package:http/http.dart' as http;

class ForumService {
  static Future<List<ForumQuestion>> getQuestions() async {
    var response = await http.get(Uri.parse(getForumRoute("questions")));
    print(getForumRoute("questions"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      List<ForumQuestion> questions = [];
      for (var i = 0; i < data.length; i++) {
        questions.add(ForumQuestion.fromJson(data[i]));
      }
      return questions;
    } else {
      print(jsonDecode(response.body));
      return [];
    }
  }

  static Future<ForumQuestion> getQuestion(String id) async {
    var response =
        await http.get(Uri.parse(getForumRoute("questions/id?id=$id")));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ForumQuestion.fromJson(data);
    } else {
      print(jsonDecode(response.body));
      return ForumQuestion();
    }
  }

  static Future<List<ForumQuestion>> getRecentQuestions(
      int page, int pageSize) async {
    var response = await http.get(Uri.parse(
        getForumRoute("questions/recent?page=$page&pageSize=$pageSize")));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<ForumQuestion> questions = [];
      for (var i = 0; i < data.length; i++) {
        questions.add(ForumQuestion.fromJson(data[i]));
      }
      return questions;
    } else {
      print(jsonDecode(response.body));
      return [];
    }
  }

  static Future<List<ForumQuestion>> searchQuestions(
      String query, int page, int pageSize) async {
    var response = await http.get(Uri.parse(getForumRoute(
        "questions/search?query=$query&page=$page&pageSize=$pageSize")));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<ForumQuestion> questions = [];
      for (var i = 0; i < data.length; i++) {
        questions.add(ForumQuestion.fromJson(data[i]));
      }
      return questions;
    } else {
      print(jsonDecode(response.body));
      return [];
    }
  }

  static Future<List<ForumQuestion>> getQuestionsByAuthor(
      String authorId, int page, int pageSize) async {
    var response = await http.get(Uri.parse(getForumRoute(
        "questions/author?authorId=$authorId&page=$page&pageSize=$pageSize")));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<ForumQuestion> questions = [];
      for (var i = 0; i < data.length; i++) {
        questions.add(ForumQuestion.fromJson(data[i]));
      }
      return questions;
    } else {
      print(jsonDecode(response.body));
      return [];
    }
  }

  static Future<List<ForumQuestion>> getQuestionsByKeywords(
      int page, int pageSize, List<String> keywords) async {
    var response = await http.get(Uri.parse(getForumRoute(
        "questions/keywords?page=$page&pageSize=$pageSize&keywords=${keywords.join(",")}")));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<ForumQuestion> questions = [];
      for (var i = 0; i < data.length; i++) {
        questions.add(ForumQuestion.fromJson(data[i]));
      }
      return questions;
    } else {
      print(jsonDecode(response.body));
      return [];
    }
  }

  static Future<List<ForumQuestion>> getQuestionsBetweenDates(
      int page, int pageSize, DateTime start, DateTime end) async {
    var response = await http.get(Uri.parse(getForumRoute(
        "questions/dates?page=$page&pageSize=$pageSize&start=${start.toIso8601String()}&end=${end.toIso8601String()}")));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<ForumQuestion> questions = [];
      for (var i = 0; i < data.length; i++) {
        questions.add(ForumQuestion.fromJson(data[i]));
      }
      return questions;
    } else {
      print(jsonDecode(response.body));
      return [];
    }
  }

  static Future<void> addQuestion(ForumQuestion question) async {
    print(jsonEncode(ForumQuestion.toJson(question)));
    var response = await http.post(
      Uri.parse(getForumRoute("questions")),
      body: jsonEncode(ForumQuestion.toJson(question)),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Failed to add question");
    }
  }

  static Future<void> deleteQuestion(String id) async {
    var response =
        await http.delete(Uri.parse(getForumRoute("questions?id=$id")));
    if (response.statusCode == 200) {
      return;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Failed to delete question");
    }
  }

  static Future<void> upvoteQuestion(String questionId) async {
    var response = await http.put(
        Uri.parse(getForumRoute("questions/upvote?questionId=$questionId")));
    if (response.statusCode == 200) {
      return;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Failed to upvote question");
    }
  }

  static Future<void> downvoteQuestion(String questionId) async {
    var response = await http.put(
        Uri.parse(getForumRoute("questions/downvote?questionId=$questionId")));
    if (response.statusCode == 200) {
      return;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Failed to downvote question");
    }
  }

  static Future<void> addAnswer(String questionId, ForumAnswer answer) async {
    var response = await http.post(
        Uri.parse(getForumRoute("answers?questionId=$questionId")),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(ForumAnswer.toJson(answer)));
    if (response.statusCode == 200) {
      return;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Failed to add answer");
    }
  }

  static Future<void> deleteAnswer(String questionId, String answerId) async {
    var response = await http.delete(Uri.parse(
        getForumRoute("answers?questionId=$questionId&answerId=$answerId")));
    if (response.statusCode == 200) {
      return;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Failed to delete answer");
    }
  }

  static Future<void> upvoteAnswer(String questionId, String answerId) async {
    var response = await http.put(Uri.parse(getForumRoute(
        "answers/upvote?questionId=$questionId&answerId=$answerId")));
    if (response.statusCode == 200) {
      return;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Failed to upvote answer");
    }
  }

  static Future<void> downvoteAnswer(String questionId, String answerId) async {
    var response = await http.put(Uri.parse(getForumRoute(
        "answers/downvote?questionId=$questionId&answerId=$answerId")));
    if (response.statusCode == 200) {
      return;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Failed to downvote answer");
    }
  }

  static Future<void> acceptAnswer(String questionId, String answerId) async {
    var response = await http.put(Uri.parse(getForumRoute(
        "answers/accept?questionId=$questionId&answerId=$answerId")));
    if (response.statusCode == 200) {
      return;
    } else {
      print(jsonDecode(response.body));
      throw Exception("Failed to accept answer");
    }
  }
}
