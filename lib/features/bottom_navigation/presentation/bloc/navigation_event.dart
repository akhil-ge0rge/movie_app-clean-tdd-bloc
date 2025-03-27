part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class ChangeIndex extends NavigationEvent {
  final int index;

  const ChangeIndex({required this.index});

  @override
  List<Object?> get props => [index];
}
