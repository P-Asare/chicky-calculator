import "package:flutter/material.dart";

import '../mod/mybutton.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var questionText = '';
  var answerText = '';
  var previousAns = '';

  final List<String> buttonVals = [
    "C",
    "Del",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "+",
    "3",
    "2",
    "1",
    "-",
    "0",
    ".",
    "ANS",
    "=",
  ];

  Color determineButtonColor(String val) {
    if (val == '%' ||
        val == '/' ||
        val == 'x' ||
        val == '+' ||
        val == '-' ||
        val == '=') {
      return Colors.purple;
    } else if (val == 'C') {
      return Colors.green;
    } else if (val == 'Del') {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  Color determineTextColor(String val) {
    if (val == '%' ||
        val == '/' ||
        val == 'x' ||
        val == '+' ||
        val == '-' ||
        val == '=' ||
        val == 'C' ||
        val == 'Del') {
      return Colors.white;
    }
    return Colors.purple;
  }

  void clickAction(dynamic quest, String val) {
    String ans;

    if (val == 'C') {
      ans = '';
    } else if (val == 'Del') {
      ans = quest.substring(0, quest.length - 1);
    } else {
      ans = quest + val;
    }

    setState(() {
      quest = ans;
    });
  }

  double evaluateExp(String expres) {
    // correct multiplication symbol
    expres = expres.replaceAll('x', '*');

    // Evaluate expression
    Parser p = Parser();
    Expression exp = p.parse(expres);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    return eval;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(children: <Widget>[
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      questionText,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      answerText,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
              child: GridView.builder(
            itemCount: buttonVals.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemBuilder: (context, index) => MyButton(
                buttonCol: determineButtonColor(buttonVals[index]),
                textCol: determineTextColor(buttonVals[index]),
                val: buttonVals[index],
                clickAction: () {
                  // Append button value to question

                  String val = buttonVals[index];

                  if (val == 'C') {
                    setState(() {
                      questionText = '';
                      answerText = '';
                    });
                  } else if (val == 'Del') {
                    setState(() {
                      questionText =
                          questionText.substring(0, questionText.length - 1);
                    });
                  } else if (val == "=") {
                    setState(() {
                      answerText = evaluateExp(questionText).toString();
                      previousAns = answerText;
                    });
                  } else if (val == 'ANS') {
                    setState(() {
                      questionText += previousAns;
                    });
                  } else {
                    setState(() {
                      questionText += val;
                    });
                  }
                }),
          )),
        ),
      ]),
    );
  }
}
