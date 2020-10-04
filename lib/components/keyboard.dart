import 'package:flutter/material.dart';
import 'button.dart';
import 'button_row.dart';

class Keyboard extends StatelessWidget {

  final void Function(String) callback;
  final String value;

  Keyboard(this.value, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      child: Column(children: <Widget>[
    ButtonRow([
      Button(text: value != '0' ? 'C' : 'AC', callback: callback),
      Button(text: '+/-', callback: callback),
      Button(text: '%', callback: callback),
      Button.operation(text: '÷', callback: callback),
    ]),
    ButtonRow([
      Button.number(text: '7', callback: callback),
      Button.number(text: '8', callback: callback),
      Button.number(text: '9', callback: callback),
      Button.operation(text: 'x', callback: callback),
    ]),
    ButtonRow([
      Button.number(text: '4', callback: callback),
      Button.number(text: '5', callback: callback),
      Button.number(text: '6', callback: callback),
      Button.operation(text: '-', callback: callback),
    ]),
    ButtonRow([
      Button.number(text: '1', callback: callback),
      Button.number(text: '2', callback: callback),
      Button.number(text: '3', callback: callback),
      Button.operation(text: '+', callback: callback),
    ]),
    ButtonRow([
      Button.big(text: '0', callback: callback),
      Button.number(text: ',', callback: callback),
      Button.operation(text: '=', callback: callback),
    ]),
  ]
),
    );
  }
}
