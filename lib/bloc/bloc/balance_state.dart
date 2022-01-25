// ignore_for_file: must_be_immutable, duplicate_ignore

part of 'balance_bloc.dart';

// ignore: duplicate_ignore
@immutable
// ignore: must_be_immutable
abstract class BalanceState {
  int value = 0;

  BalanceState({required this.value});
}

class BalanceInitial extends BalanceState {
  BalanceInitial(int value) : super(value: value);
}

class BalanceResult extends BalanceState {
  BalanceResult(int value) : super(value: value);
}
