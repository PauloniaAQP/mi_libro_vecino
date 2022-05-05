// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/app/app.dart';
import 'package:mi_libro_vecino/search/cubit/search_cubit.dart';
import 'package:mi_libro_vecino/search/view/search_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchCubit extends MockCubit<SearchState> implements SearchCubit {}

void main() {
  late SearchCubit searchCubit;

  setUp(() {
    searchCubit = MockSearchCubit();
  });
  group('App', () {
    setUp(() {});
    testWidgets('renders App view', (tester) async {
      const state = SearchState(
        isSearching: false,
      );
      when(() => searchCubit.state).thenReturn(state);
      await tester.pumpWidget(
        BlocProvider.value(
          value: searchCubit,
          child: const AppView(),
        ),
      );
      expect(find.byType(SearchPage), findsOneWidget);
    });
  });
}
