import 'dart:ui';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = '';
  String userInput = '';

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: resultWidget(),
          ),
          Flexible(
            flex: 2,
            child: buttonsWidget(),
          ),
        ],
      ),
    ));
  }

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(16),
          child: Text(
            userInput,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(16),
          child: Text(
            result,
            style: const TextStyle(
              fontSize: 48,
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonsWidget() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: buttonList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return button(buttonList[index]);
      },
    );
  }

  Widget button(String text) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: MaterialButton(
        onPressed: () {
          //Vibration
          HapticFeedback.mediumImpact();

          setState(() {
            handleButtonPress(text);
          });
        },
        color: getColor(text),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == 'AC') {
      userInput = "";
      result = '';
      return;
    }
    if (text == 'C') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
      }

      return;
    }

    if (isOperator(text) &&
        userInput.isNotEmpty &&
        isOperator(userInput[userInput.length - 1])) {
      return;
    }

    if (text == '=') {
      result = calculate();
      if (result.endsWith('.0')) result = result.replaceAll('.0', '');
      return;
    }

    return userInput += text;
  }

  bool isOperator(String character) {
    return character == '+' ||
        character == '-' ||
        character == '*' ||
        character == '/';
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'error';
    }
  }

  getColor(String text) {
    if (text == '/' || text == '*' || text == '+' || text == '-') {
      return const Color.fromARGB(255, 188, 234, 255);
    }

    if (text == 'C' || text == 'AC') {
      return const Color.fromARGB(255, 255, 166, 159);
    }

    return Colors.white;
  }
}
