import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mi_libro_vecino/libraries/view/libraries_page.dart';
import 'package:mi_libro_vecino/search/cubit/search_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockLibrariesCubit extends MockCubit<LibrariesState>
    implements LibrariesCubit {}

class MockSearchCubit extends MockCubit<SearchState> implements SearchCubit {}

class MockAppUserBloc extends MockBloc<AppUserEvent, AppUserState>
    implements AppUserBloc {}

void main() {
  group('Libraries list page', () {
    late LibrariesCubit librariesCubit;
    late SearchCubit searchCubit;
    late AppUserBloc appUserBloc;

    setUp(() {
      librariesCubit = MockLibrariesCubit();
      searchCubit = MockSearchCubit();
      appUserBloc = MockAppUserBloc();
    });

    testWidgets('renders libraries list Page', (tester) async {
      const state = LibrariesInitial();
      const searchState = SearchInitial();
      final appUserState = AppUserInitial();
      when(() => librariesCubit.state).thenReturn(state);
      when(() => searchCubit.state).thenReturn(searchState);
      when(() => appUserBloc.state).thenReturn(appUserState);
      await tester.pumpApp(
        BlocProvider.value(
          value: searchCubit,
          child: BlocProvider.value(
            value: librariesCubit,
            child: BlocProvider.value(
              value: appUserBloc,
              child: const LibrariesPage(),
            ),
          ),
        ),
      );
      // TODO(oscarnar): Make test for http request
      // expect(
      //   find.text(
      //     'Soy colaborador',
      //   ),
      //   findsOneWidget,
      // );
    });
  });
}
