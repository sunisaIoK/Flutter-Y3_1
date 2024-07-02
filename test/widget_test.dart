// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _input = '';
        _result = '0.0';
      } else if (buttonText == 'C') {
        _input = '';
      } else if (buttonText == '=') {
        try {
          _result = eval(_input).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _input += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: SizedBox(
        width: 400.0,
        height: 900.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_input, style: const TextStyle(fontSize: 20.0)),
                  const SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(_result,
                        style: const TextStyle(
                            fontSize: 36.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Expanded(child: buildCalculatorButtons()),
          ],
        ),
      ),
    );
  }

  Widget buildCalculatorButtons() {
    List<List<String>> buttonRows = [
      ['AC', 'C', '/'],
      ['7', '8', '9', 'x'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '='],
    ];

    return Column(
      children: buttonRows
          .map((row) => Row(
                children: row
                    .map((buttonText) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RawMaterialButton(
                              onPressed: () => _onButtonPressed(buttonText),
                              elevation: 2.0,
                              fillColor: getButtonColor(buttonText),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  buttonText,
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: getFontColor(buttonText)),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ))
          .toList(),
    );
  }

  Color getButtonColor(String buttonText) =>
      ['/', 'x', '+', '-', '='].contains(buttonText)
          ? Colors.yellow
          : Colors.blue;

  Color getFontColor(String buttonText) =>
      ['/', 'x', '+', '-', '='].contains(buttonText)
          ? Colors.black
          : Colors.white;

  double eval(String expression) {
    expression = expression.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }
}
