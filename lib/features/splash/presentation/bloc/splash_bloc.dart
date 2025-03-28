import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStart>(_handleSplashStart);
  }

  Future<void> _handleSplashStart(
    SplashStart event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3), () {});
    emit(SplashLoaded());
  }
}
