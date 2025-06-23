import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyCalculator());
}

class MyCalculator extends StatelessWidget {

  const MyCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {

  const Calculator({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Calculator();
  }

}
class _Calculator extends State<Calculator> {

  var userInput = '';
  var answer = '';

  // Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.only(left: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(userInput,
                    style: const TextStyle(
                        fontSize: 60,
                        color: Colors.white
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(answer,
                    style: const TextStyle(
                        fontSize: 60,
                        color: Colors.white
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("C", Color(0xffa5a5a5),0),
                button("+/-", Color.fromRGBO(165, 165, 165, 1),1),
                button("%", Color(0xffa5a5a5),2),
                button("/", Color(0xffff9800),7),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("7", Color(0xff323232),4),
                button("8", Color(0xff323232),5),
                button("9", Color(0xff323232),6),
                button("x", Color(0xffff9800),11),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("4", Color(0xff323232),8),
                button("5", Color(0xff323232),9),
                button("6", Color(0xff323232),10),
                button("-", Color(0xffff9800),15),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("1", Color(0xff323232),12),
                button("2", Color(0xff323232),13),
                button("3", Color(0xff323232),14),
                button("+", Color(0xffff9800),19),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("0", Color(0xff323232),16),
                button(".", Color(0xff323232),17),
                button("=", Color(0xffff9800),18),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button (String txt, Color color, int index){

    Container container;

    if (index == 16){
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: MaterialButton(
            onPressed: () {equalPressed(index);},
            shape: const StadiumBorder(),
            color: color,
            padding: EdgeInsets.only(left: 80, top: 20, right: 80, bottom: 20),
            child: Text(txt,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          )
      );
    }
    else{
      container = Container(
          padding: EdgeInsets.only(bottom: 10),
          child: MaterialButton(
            onPressed: () {equalPressed(index);},
            shape: const CircleBorder(),
            color: color,
            padding: EdgeInsets.all(20),
            child: Text(txt,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          )
      );
    }

    return container;
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed(int index) {
    try {
      // Clear Button
      if (index == 0) {
        setState(() {
          userInput = '';
          answer = '0';
        });
      }
      // % Button
      else if (index == 2) {
        setState(() {
          userInput += buttons[index];
        });
      }
      // Equal_to Button
      else if (index == 18) {
        setState(() {
          String finaluserinput = userInput;
          finaluserinput = userInput.replaceAll('x', '*');

          Parser p = Parser();
          Expression exp = p.parse(finaluserinput);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          answer = eval.toString();
        });
      }

      //  other buttons
      else {
        setState(() {
          userInput += buttons[index];
        });
      }
    }catch (e) {}
  }
}

