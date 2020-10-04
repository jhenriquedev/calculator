import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const OPERATION = Color.fromRGBO(254, 158, 9, 1);
  static const NUMBER = Color.fromRGBO(51, 51, 51, 1);
  static const DEFAULT = Color.fromRGBO(165, 165, 165, 1);

  final String text;
  final int flexButton;
  final Color color;
  final bool buttonCircle;
  final bool textSpecial;
  //final void Function(String) onClick;
  final void Function(String) callback;
  //final Color.fromRGBO(r, g, b, opacity) cor;

  Button({
    this.text,
    //this.callback,
    this.callback,
    this.flexButton = 1,
    this.buttonCircle = true,
    this.textSpecial = true,
    this.color = DEFAULT,
  });

  Button.number({
    this.text,
    this.callback,
    //this.callback,
    this.flexButton = 1,
    this.buttonCircle = true,
    this.textSpecial = false,
    this.color = NUMBER,
  });

  Button.operation({
    this.text,
    this.callback,
    //this.callback,
    this.flexButton = 1,
    this.buttonCircle = true,
    this.textSpecial = false,
    this.color = OPERATION,
  });

  Button.big({
    this.text,
    this.callback,
    //this.callback,
    this.flexButton = 2,
    this.buttonCircle = false,
    this.textSpecial = false,
    this.color = NUMBER,
  });

  bool get _buttonCircle => buttonCircle;

  bool get _textSpecial => textSpecial;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexButton,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: RawMaterialButton(
          onPressed: () => callback(text),
          elevation: 2.0,
          fillColor: this.color,
          child: Align(
            alignment: _buttonCircle ? Alignment.center : Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 40,
                fontWeight: _textSpecial ? FontWeight.w200 : FontWeight.w400,
                color: _textSpecial ? Colors.black : Colors.white,
              ),
            ),
          ),
          padding: _buttonCircle
              ? EdgeInsets.all(20)
              : EdgeInsets.fromLTRB(40, 20, 0, 20),
          shape: _buttonCircle
              ? CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
        ),
      ),
    );
  }
}
