part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class ToggleNegative extends CalculatorEvent {
  @override
  String toString() => "ToggleNegative";
}

class ClearAll extends CalculatorEvent {
  @override
  String toString() => "ClearAll";
}
class Calculate extends CalculatorEvent {
  @override
  String toString() => "Calculate";
}
class AddOperator extends CalculatorEvent {
  final String operator;
  AddOperator(this.operator);
  @override
  String toString() => "AddOperator";
}
class AddNumber extends CalculatorEvent {
  final int number;
  AddNumber(this.number);
  @override
  String toString() => "AddNumber";
}
class AddDot extends CalculatorEvent {
  @override
  String toString() => "AddDot";
}
class RemoveNumber extends CalculatorEvent {
  @override
  String toString() => "RemoveNumber";
}
