import 'package:bloc/bloc.dart';

class ProductControllerButtonIncrementDecrement extends Cubit<int> {
  late final bool _hasOrder;

  ProductControllerButtonIncrementDecrement() : super(1);

  void initial(int amount, bool hasOrder) {
    _hasOrder = hasOrder;
    emit(amount);
  }

  void incremement() => emit(state + 1);
  void decrement() {
    if (state > (_hasOrder ? 0 : 1)) {
      emit(state - 1);
    }
  }
}
