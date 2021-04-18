import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  NumberButton({this.text,this.onPressed});

  final text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    if(text == "0"){
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 60.0,
          width: MediaQuery.of(context).size.width / 2.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Color.fromRGBO(56, 54, 56, 1.0)),
          child: MaterialButton(
            onPressed: onPressed,
            child: Text(
              "0",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      );
    }
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
          fillColor: Color.fromRGBO(56, 54, 56, 1.0),
        ));
  }
}