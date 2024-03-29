// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
            'storageBucket': 'mi-libro-vecino-dev.appspot.com',
          },
          'pluginConstants': {
            'kGoogleSignInPlugin': '123',
            'kGoogleSignInPluginVersion': '123',
          },
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return {
        'name': 'name', //call.arguments['appName'],
        'options': 'options', //call.arguments['options'],
        'pluginConstants': {
          'kGoogleSignInPlugin': '123',
          'kGoogleSignInPluginVersion': '123',
        },
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future<T>.delayed(const Duration(minutes: 5));
  }
}
