// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mi_libro_vecino/router/router.dart';
import 'package:mi_libro_vecino/search/cubit/search_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/theme.dart';
import 'package:mi_libro_vecino_api/repositories/library_repository.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';
import 'package:mi_libro_vecino_api/services/ubigeo_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(oscarnar): Change this, we need be more organized
    Get
      ..put(UserRepository(), permanent: true)
      ..put(LibraryRepository(), permanent: true);

    final ubigeoService = UbigeoService()..init();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppUserBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => SearchCubit(ubigeoService),
        ),
        BlocProvider(
          create: (context) => LibrariesCubit(),
        ),
        BlocProvider(
          create: (context) => CollaboratorCubit(),
        ),
        BlocProvider(
          create: (context) => AdminCubit(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: PTheme.standard,
      scrollBehavior: MyCustomScrollBehavior(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('es'),
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
