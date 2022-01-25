import 'package:bloc/bloc.dart';
import 'package:firstapk/bloc/balance/add.dart';
import 'package:meta/meta.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc() : super(BalanceInitial(0)) {
    on<BalanceEvent>((event, emit) {
      if (event is AddBalance) {
        emit(BalanceResult(Add.temp));
      }
    });
  }
}
