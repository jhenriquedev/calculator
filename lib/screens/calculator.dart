import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/display.dart';
import '../components/keyboard.dart';
import '../models/memory.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();

  _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([ 
      DeviceOrientation.portraitUp //apenas retrato pra cima
    ]);
    return MaterialApp(
      home: Container(
        //hexadecimal => 0xFF + código
        color: Color.fromRGBO(0, 0, 0, 1), //Color(0xFF0B0D0F)
        child: Column(
          children: <Widget>[
            Display(memory.value),
            Keyboard(memory.value, _onPressed),
          ],
        ),
      ),
    );
  }
}
