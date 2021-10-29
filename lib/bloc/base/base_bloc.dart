import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dalotee/bloc/base/base_state.dart';

abstract class BaseBloc<T extends BaseState> extends Cubit<T> {
  BaseBloc(T state) : super(state);
}
