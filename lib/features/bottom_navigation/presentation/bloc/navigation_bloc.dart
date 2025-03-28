import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(index: 0)) {
    on<ChangeIndex>(_handleChangeIndexEvent);
  }

  void _handleChangeIndexEvent(
    ChangeIndex event,
    Emitter<NavigationState> emit,
  ) {
    emit(NavigationState(index: event.index));
  }
}
