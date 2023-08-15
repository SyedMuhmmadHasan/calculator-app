import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  String _currentInput = '';

  void _addToInput(String value) {
    setState(() {
      _currentInput += value;
    });
  }

  void _calculateResult() {
    Parser p = Parser();
    ContextModel cm = ContextModel();

    try {
      Expression exp = p.parse(_currentInput);
      double result = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _currentInput = result.toString();
      });
    } catch (e) {
      setState(() {
        _currentInput = 'Error';
      });
    }
  }

  void _clearInput() {
    setState(() {
      _currentInput = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> buttonColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.amber,
      Colors.indigo,
      Colors.lime,
      Colors.brown,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.grey,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Calculator',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Created by Hasan',
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.bottomRight,
            child: Text(
              _currentInput,
              style: const TextStyle(fontSize: 32.0),
            ),
          ),
          const Divider(height: 1.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 16,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final buttonText = <String>[
                    '7',
                    '8',
                    '9',
                    '/',
                    '4',
                    '5',
                    '6',
                    '*',
                    '1',
                    '2',
                    '3',
                    '-',
                    '0',
                    '.',
                    '=',
                    'C',
                  ];
                  return buildButton(buttonText[index], buttonColors[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String value, Color buttonColor) {
    return Container(
      color: buttonColor,
      child: TextButton(
        onPressed: () {
          if (value == '=') {
            _calculateResult();
          } else if (value == 'C') {
            _clearInput();
          } else {
            _addToInput(value);
          }
        },
        child: Text(
          value,
          style: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
