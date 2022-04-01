import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart' as utils;

void main() {
  group('Register cubit test', () {
    late utils.Coordinates coordinates;

    setUp(() {
      coordinates = utils.Coordinates(-17, -51);
    });

    test('Initial state index is 0', () {
      expect(RegisterCubit().state.index, 0);
    });

    blocTest<RegisterCubit, RegisterState>(
      'The cubit should be on index 1',
      build: () => RegisterCubit(),
      act: (cubit) => cubit.setMapLocation(coordinates),
      expect: () => [
        RegisterInitial().copyWith(location: coordinates),
      ],
    );
  });
}
