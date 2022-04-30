// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:catcher/catcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:mi_libro_vecino/app/app.dart';
import 'package:mi_libro_vecino/bloc_observer.dart';
import 'package:mi_libro_vecino/bootstrap.dart';
import 'package:paulonia_error_service/paulonia_error_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final catcherConf = PauloniaErrorService.getCatcherConfig();

  Catcher(
    runAppFunction: () {
      unawaited(
        bootstrap(
          () => BlocOverrides.runZoned(
            () => const App(),
            blocObserver: MyLibroVecinoBlocObserver(),
          ),
        ),
      );
    },
    debugConfig: catcherConf['debug'],
    releaseConfig: catcherConf['release'],
    profileConfig: catcherConf['profile'],
  );
}
