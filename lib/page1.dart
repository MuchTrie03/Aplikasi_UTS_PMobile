import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyCalculatorApp());
}

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Kalkulator'),
      ),
      body: CalculatorScreen(), // Panggil kalkulator di halaman ini
    );
  }
}

// Halaman Kalkulator
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '';
  String previousDisplayText = '';
  String? currentOperator;
  double? num1;
  double? num2;
  String? operation;

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        displayText = '';
        previousDisplayText = '';
        currentOperator = null;
        num1 = null;
        num2 = null;
        operation = null;
      } else if (value == 'CE') {
        displayText = '';
      } else if (value == '+' ||
          value == '-' ||
          value == 'x' ||
          value == '/' ||
          value == '^' ||
          value == '√') {
        if (displayText.isNotEmpty) {
          num1 = double.tryParse(displayText);
          previousDisplayText = displayText;
          currentOperator = value;
          displayText = '';
          operation = value;
        }
      } else if (value == '=') {
        num2 = double.tryParse(displayText);
        if (num1 != null && num2 != null) {
          switch (operation) {
            case '+':
              displayText = (num1! + num2!).toString();
              break;
            case '-':
              displayText = (num1! - num2!).toString();
              break;
            case 'x':
              displayText = (num1! * num2!).toString();
              break;
            case '/':
              displayText = (num2 != 0) ? (num1! / num2!).toString() : 'Error';
              break;
            case '^':
              displayText = pow(num1!, 2).toString();
              break;
            case '√':
              displayText = (num1! >= 0) ? sqrt(num1!).toString() : 'Error';
              break;
          }
          previousDisplayText = '';
          currentOperator = null;
          num1 = null;
          num2 = null;
          operation = null;
        }
      } else {
        displayText += value;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(text),
        child: Text(text, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$previousDisplayText ${currentOperator ?? ''}',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
                Text(
                  displayText,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Row(children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/')
            ]),
            Row(children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('x')
            ]),
            Row(children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-')
            ]),
            Row(children: <Widget>[
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+')
            ]),
            Row(children: <Widget>[
              _buildButton('CE'),
              _buildButton('√'),
              _buildButton('^'),
            ])
          ],
        ),
      ],
    );
  }
}
