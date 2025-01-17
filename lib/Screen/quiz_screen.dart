import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Provider/home_provider.dart';
import 'package:quiz_app/Screen/item/quiz_item.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool loading = false;
  int indexIncrease = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    Provider.of<HomeProvider>(context, listen: false).fetchQuiz().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerItem = Provider.of<HomeProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(title: const Text("Quiz App")),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : providerItem.quizModal?.questions?.length == indexIncrease + 1
                ? Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(top: 250),
                    child:const Text(
                      "Quiz is completed !",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  )
                : ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return QuizItem(
                        question: providerItem
                                .quizModal
                                ?.questions?[index + indexIncrease]
                                .description ??
                            "",
                        optionAnswer: providerItem.quizModal
                            ?.questions?[index + indexIncrease].options,
                        onTapxxx: () {
                          if (providerItem.quizModal?.questions?.length !=
                              indexIncrease + 1) {
                            setState(() {
                              indexIncrease = indexIncrease + 1;
                            });
                          }
                        },
                      );
                    },
                  ));
  }
}
