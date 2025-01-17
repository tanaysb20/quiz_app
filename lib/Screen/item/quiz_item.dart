import 'package:flutter/material.dart';
import 'package:quiz_app/modals/quiz_modal.dart';

// ignore: must_be_immutable
class QuizItem extends StatefulWidget {
  String question;
  List<Options>? optionAnswer;
  VoidCallback onTapxxx;

  QuizItem(
      {super.key,
      this.question = "",
      required this.optionAnswer,
      required this.onTapxxx});

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  int selectedId = 0;
  bool check = false;
  Options? selectedTest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Options? txselectedTest = widget.optionAnswer?.firstWhere((test) {
      return test.isCorrect == true;
    });
    selectedTest = txselectedTest;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            widget.question,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          ...(widget.optionAnswer)!.map((element) {
            return InkWell(
              onTap: () {
                selectedId = element.id ?? 0;
                // widget.onTapxxx();

                if (selectedId == element.id && element.isCorrect == true) {
                  check = true;
                }
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.only(
                    right: 40, bottom: 8, top: 8, left: 20),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: selectedId == element.id && element.isCorrect == true
                      ? Colors.green
                      : selectedId == element.id && element.isCorrect == false
                          ? Colors.red
                          : Colors.yellow,
                ),
                child: Text(
                  element.description ?? "",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            );
          }),
          if (check)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.onTapxxx();
                    check = false;
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
