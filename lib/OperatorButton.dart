import 'package:flutter/material.dart';

class OperatorButton extends StatelessWidget {
  OperatorButton({this.text,this.onPressed});

  final text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          constraints: BoxConstraints.tight(Size(60.0, 60.0)),
          onPressed:onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          fillColor: Colors.orange,
        ));
  }

}