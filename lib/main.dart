import 'package:flutter/material.dart';
import 'NumberButton.dart';
import 'OperatorButton.dart';
import 'package:calculator_assignment/Bloc/calculator/calculator_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
      home: BlocProvider(
          create: (BuildContext context) => CalculatorBloc(),
          child: Calculator()),
    );
  }
}

class Calculator extends StatelessWidget {
  CalculatorBloc _calculatorBloc;

  @override
  Widget build(BuildContext context) {
    _calculatorBloc = BlocProvider.of<CalculatorBloc>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder(
            bloc: _calculatorBloc,
            builder: (BuildContext context, CalculatorState state) {
              if (state is InitialCalculatorState) {
                _calculatorBloc.add(ClearAll());
                return SizedBox();
              }
              if (state is CalculateState) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      buildOperandWidget(state),
                      buildNumberWidget(),
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            }),
    );
  }

  //Widget

  Widget buildOperandWidget(CalculateState state) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(16),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("${state.calculatorModel.inputFull}  ${state.calculatorModel.operator}",
                          style: TextStyle(fontSize: 18)),
                      Text(state.calculatorModel.operand,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ))
                    ]))));
  }

  Widget buildNumberWidget() {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberButton(
                  text: "C",
                  onPressed: () {
                    _calculatorBloc.add(ClearAll());
                  }),
              NumberButton(
                  text: "±",
                  onPressed: () {
                    _calculatorBloc.add(ToggleNegative());
                  }),
              NumberButton(
                  text: "⌫",
                  onPressed: () {
                    _calculatorBloc.add(RemoveNumber());
                  }),
              OperatorButton(
                  text: "÷",
                  onPressed: () {
                    _calculatorBloc.add(AddOperator("÷"));
                  }),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberButton(
                  text: "7",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(7));
                  }),
              NumberButton(
                  text: "8",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(8));
                  }),
              NumberButton(
                  text: "9",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(9));
                  }),
              OperatorButton(
                  text: "×",
                  onPressed: () {
                    _calculatorBloc.add(AddOperator("×"));
                  }),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberButton(
                  text: "4",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(4));
                  }),
              NumberButton(
                  text: "5",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(5));
                  }),
              NumberButton(
                  text: "6",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(6));
                  }),
              OperatorButton(
                  text: "−",
                  onPressed: () {
                    _calculatorBloc.add(AddOperator("-"));
                  }),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberButton(
                  text: "1",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(1));
                  }),
              NumberButton(
                  text: "2",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(2));
                  }),
              NumberButton(
                  text: "3",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(3));
                  }),
              OperatorButton(
                  text: "+",
                  onPressed: () {
                    _calculatorBloc.add(AddOperator("+"));
                  }),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberButton(
                  text: "0",
                  onPressed: () {
                    _calculatorBloc.add(AddNumber(0));
                  }),
              NumberButton(
                  text: ".",
                  onPressed: () {
                    _calculatorBloc.add(AddDot());
                  }),
              OperatorButton(
                  text: "=",
                  onPressed: () {
                    _calculatorBloc.add(Calculate());
                  }),
            ]),
      ],
    ));
  }
}