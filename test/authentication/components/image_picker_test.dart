import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/authentication/components/pick_image.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockSearchCubit extends MockCubit<RegisterState>
    implements RegisterCubit {}

void main() {
  group('Test pick image component', () {
    late RegisterCubit registerCubit;
    late String imagePath;

    setUp(() {
      registerCubit = MockSearchCubit();
      imagePath = 'assets/images/test_images/register_image.png';
    });

    Future<Uint8List> chargeImage(String path) async {
      final asset = await rootBundle.load(path);
      final bytes = asset.buffer.asUint8List();
      return bytes;
    }

    testWidgets('renders pick image component', (tester) async {
      final state = RegisterInitial();
      when(() => registerCubit.state).thenReturn(state.copyWith(index: 6));
      final image = await chargeImage(imagePath);
      await tester.pumpApp(
        BlocProvider.value(
          value: registerCubit,
          child: Card(
            child: PickImage(
              image: image,
              onTap: () {},
              pickLabel: 'Select image',
              modifyLabel: 'Modify image',
              unselectedPhotoIconPath: imagePath,
              selectedPhotoIconPath: imagePath,
            ),
          ),
        ),
      );
      expect(
        find.text(
          'Modify image',
        ),
        findsOneWidget,
      );
    });
  });
}
