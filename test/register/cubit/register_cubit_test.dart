import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';

void main() {
  group('Register cubit test', () {
    late int secondIndex;

    setUp(() {
      secondIndex = 1;
    });

    test('Initial state index is 0',
        () {
      expect(RegisterCubit().state.index, 0);
    });

    blocTest<RegisterCubit, RegisterState>(
      'The cubit should be on index 1',
      build: () => RegisterCubit(),
      act: (cubit) => cubit.nextPage(),
      expect: () => [
        RegisterInitial().copyWith(index: secondIndex),
      ],
    );
  });
}
