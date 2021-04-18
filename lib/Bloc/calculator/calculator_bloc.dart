import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:calculator_assignment/model/CalculatorModel.dart';
part 'calculator_event.dart';

part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  @override
  CalculatorState get initialState => InitialCalculatorState();

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {
    if (event is ToggleNegative) {
      yield* _mapToggleNegativeToState();
    }  else if (event is ClearAll) {
      yield* _mapSClearAllToState();
    } else if (event is Calculate) {
      yield* _mapCalculateToState();
    } else if (event is AddOperator) {
      yield* _mapAddOperatorToState(event);
    } else if (event is AddNumber) {
      yield* _mapAddNumberToState(event);
    } else if (event is AddDot) {
      yield* _mapAddDotToState();
    } else if (event is RemoveNumber) {
      yield* _mapRemoveNumberToState();
    }
  }

  Stream<CalculatorState> _mapToggleNegativeToState() async* {
    var calculatorModel = (state as CalculateState).calculatorModel;
    if (calculatorModel.operand.contains("-") || calculatorModel.operand == "0")
      calculatorModel.operand = calculatorModel.operand.replaceAll("-", "");
    else
      calculatorModel.operand = "-" + calculatorModel.operand;
    yield CalculateState(calculatorModel);
  }

  Stream<CalculatorState> _mapSClearAllToState() async* {
    var calculatorModel = CalculatorModel("0","","","",false);
    yield CalculateState(calculatorModel);
  }

  Stream<CalculatorState> _mapCalculateToState() async* {
    var calculatorModel = (state as CalculateState).calculatorModel;
    if (calculatorModel.calculateMode) {
      bool decimalMode = false;
      double value = 0;
      if (calculatorModel.operand.contains(".") || calculatorModel.operandTemp.contains(".")) {
        decimalMode = true;
      }

      if (calculatorModel.operator == "+")
        value = (double.parse(calculatorModel.operandTemp) + double.parse(calculatorModel.operand));
      else if (calculatorModel.operator == "-")
        value = (double.parse(calculatorModel.operandTemp) - double.parse(calculatorModel.operand));
      else if (calculatorModel.operator == "×")
        value = (double.parse(calculatorModel.operandTemp) * double.parse(calculatorModel.operand));
      else if (calculatorModel.operator == "÷")
        value = (double.parse(calculatorModel.operandTemp) / double.parse(calculatorModel.operand));

      if (!decimalMode)
        calculatorModel.operand = value.toInt().toString();
      else
        calculatorModel.operand = value.toString();

      calculatorModel.inputFull = "";
      calculatorModel.calculateMode = false;
      calculatorModel.operator = "";
      calculatorModel.operandTemp = "";

      yield CalculateState(calculatorModel);
    }
  }

  Stream<CalculatorState> _mapAddOperatorToState(AddOperator event) async* {
    var calculatorModel = (state as CalculateState).calculatorModel;
    if (calculatorModel.operand != "0" && !calculatorModel.calculateMode) {
      calculatorModel.calculateMode = true;
      calculatorModel.operandTemp = calculatorModel.operand;
      calculatorModel.inputFull += calculatorModel.operator + " " + calculatorModel.operandTemp;
      calculatorModel.operator = event.operator;
      calculatorModel.operand = "0";
    } else if (calculatorModel.calculateMode) {
      if (calculatorModel.operand.isNotEmpty) {
        _mapCalculateToState();
      } else {
        calculatorModel.operator = event.operator;
      }
    }
    yield CalculateState(calculatorModel);
  }

  Stream<CalculatorState> _mapAddNumberToState(AddNumber event) async* {
    var number = event.number;
    var calculatorModel = (state as CalculateState).calculatorModel;
    if (number == 0 && calculatorModel.operand == "0") {
      // Not do anything.
    } else if (number != 0 && calculatorModel.operand == "0") {
      calculatorModel.operand = number.toString();
    } else {
      calculatorModel.operand += number.toString();
    }
    yield CalculateState(calculatorModel);
  }

  Stream<CalculatorState> _mapAddDotToState() async* {
    var calculatorModel = (state as CalculateState).calculatorModel;

    if (!calculatorModel.operand.contains(".")) calculatorModel.operand = calculatorModel.operand + ".";

    yield CalculateState(calculatorModel);
  }

  Stream<CalculatorState> _mapRemoveNumberToState() async* {
    var calculatorModel = (state as CalculateState).calculatorModel;
    if (calculatorModel.operand == "0") {
      // Not do anything.
    } else {
      if (calculatorModel.operand.length > 1) {
        calculatorModel.operand = calculatorModel.operand.substring(0, calculatorModel.operand.length - 1);
      } else {
        calculatorModel.operand = "0";
      }
    }
    yield CalculateState(calculatorModel);
  }
}
