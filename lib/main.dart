import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  State createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator>{

  String equation = "0";
  String result = "0";
  String expression = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(equation,),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(result, ),
          ),

          Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton("C", ),
                        buildButton("Undo",),
                        buildButton("Redo",),
                        buildButton("/",),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton("7",),
                        buildButton("8",),
                        buildButton("9",),
                        buildButton("*",),

                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton("4",),
                        buildButton("5",),
                        buildButton("6",),
                        buildButton("+",),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton("1",),
                        buildButton("2",),
                        buildButton("3",),
                        buildButton("-",),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton("0",),

                        buildButton("=",),
                      ]
                  ),
                ],
              ),
            ],
          ),
      );

  }

  Widget buildButton(String buttonText){
    return Container(
      color: Colors.green,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => onButtonPress(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          )),
    );
  }

  Stack redoStack = Stack();
  onButtonPress(String buttonText) {
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
      }
      else  if(buttonText == "Redo"){
        String element = redoStack.pop();

        if(element == "")
          return;

        if(equation == "0"){
          equation = "";
        }
        equation = equation+element;

      }
      else if(buttonText == "Undo"){
        List list = equation.split("");

        redoStack.push(list.last);
        print(list.last);
        equation = equation.substring(0,equation.length -1);
        if(equation == ""){
          equation = "0";
        }
      }else if(buttonText == "="){
        expression = equation;
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        }catch(e){
          result = "Invalid format used";
        }

      }else {
        if(equation == "0"){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        }
      }
    });
  }
}

class Stack {
  final _stack = Queue<String>();

  void push(String element) {
    _stack.addLast(element);
  }

  String pop() {
    try {
      final String lastElement = _stack.last;
      _stack.removeLast();
      return lastElement;
    }catch(e){
      print(e);
    }
    return "";
  }

  void clear() {
    _stack.clear();
  }
}