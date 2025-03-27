import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/bottom_navigation/presentation/bloc/navigation_bloc.dart';

void main() {
  group('NavigationBloc', () {
    late NavigationBloc bloc;
    setUp(() {
      bloc = NavigationBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('Initial state should be [NavigationState] with index 0', () {
      expect(bloc.state, NavigationState(index: 0));
    });

    blocTest(
      'should emit [NavigationState] with index 1 when [ChangeIndex] with 1 is added',
      build: () {
        return bloc;
      },

      act: (bloc) => bloc.add(ChangeIndex(index: 1)),
      expect: () => [NavigationState(index: 1)],
    );
  });
}
