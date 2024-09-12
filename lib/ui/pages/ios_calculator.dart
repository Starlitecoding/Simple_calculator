import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/ui/common/ios_button.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class IosCalculator extends StatefulWidget {
  const IosCalculator({super.key});

  @override
  State<IosCalculator> createState() => _IosCalculatorState();
}

class _IosCalculatorState extends State<IosCalculator> {
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
      backgroundColor: const Color(0xFF1C1C1C),
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
          padding: const EdgeInsets.only(right: 16, top: 50),
          child: Text(
            userInput,
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(16),
          child: AutoSizeText(
            result,
            style: const TextStyle(fontSize: 64, color: Colors.white),
            maxLines: 1, // Ограничиваем текст одной строкой
            minFontSize: 16, // Минимальный размер текста
            overflow: TextOverflow.ellipsis, // Добавляем многоточие при обрезке
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
        return IosButton(
          text: buttonList[index],
          onPressed: () {
            // Вибрация
            HapticFeedback.mediumImpact();

            setState(() {
              handleButtonPress(buttonList[index]);
            });
          },
        );
      },
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

    userInput += text;
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
}
