import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/Urls/url_holder_loan.dart';
import 'dart:convert';

import 'package:quiz_app/modals/quiz_modal.dart';

class HomeProvider with ChangeNotifier {
  QuizModal? quizModal;

  Future<void> fetchQuiz() async {
    final response =
        await http.get(Uri.parse('${ApiUrls.baseUrl}${ApiUrls.getQuizData}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      quizModal = QuizModal.fromJson(jsonResponse);

      notifyListeners();
    } else {
      throw Exception('Failed to load quiz modal');
    }
  }
}
