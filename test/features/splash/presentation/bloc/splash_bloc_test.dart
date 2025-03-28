import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/splash/presentation/bloc/splash_bloc.dart';

void main() {
  group('SplashBloc', () {
    late SplashBloc bloc;

    setUp(() {
      bloc = SplashBloc();
    });
    tearDown(() {
      bloc.close();
    });

    test('initial state should be [SplashInitial]', () {
      expect(bloc.state, SplashInitial());
    });

    blocTest(
      'Should emit [SplashLoaded] after a 3 second when [SplashStarted is Added]',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(SplashStart()),
      expect: () => [SplashLoaded()],
      wait: const Duration(seconds: 3),
    );
  });
}
