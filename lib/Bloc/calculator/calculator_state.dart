part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorState {}

class InitialCalculatorState extends CalculatorState {
  @override
  String toString() => "InitialCalculatorState";
}

class CalculateState extends CalculatorState {
  final CalculatorModel calculatorModel;
  CalculateState(this.calculatorModel);
  @override
  String toString() => "CalculatorState";
}
