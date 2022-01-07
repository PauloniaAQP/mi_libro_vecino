import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/libraries/view/libraries_page.dart';
import 'package:mi_libro_vecino/register/view/pages/email_register_page.dart';
import 'package:mi_libro_vecino/register/view/pages/personal_name_page.dart';
import 'package:mi_libro_vecino/register/view/register_page.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/search/search.dart';

abstract class AppRouter {
  static GoRouter get router => GoRouter(
        initialLocation: Routes.search,
        routes: [
          GoRoute(
            path: Routes.search,
            pageBuilder: (context, state) => const MaterialPage(
              child: SearchPage(),
            ),
          ),
          GoRoute(
            path: Routes.libraries,
            pageBuilder: (context, state) => const MaterialPage(
              child: LibrariesPage(),
            ),
          ),
          GoRoute(
            path: Routes.register,
            pageBuilder: (context, state) => const MaterialPage(
              child: RegisterPage(),
            ),
            routes: [
              GoRoute(
                path: Routes.emailRegister,
                pageBuilder: (context, state) => const MaterialPage(
                  child: EmailRegisterPage(),
                ),
              ),
              GoRoute(
                path: Routes.personalName,
                pageBuilder: (context, state) => const MaterialPage(
                  child: PersonalNamePage(),
                ),
              ),
              GoRoute(
                path: Routes.personalPhoto,
                pageBuilder: (context, state) => const MaterialPage(
                  child: PersonalNamePage(),
                ),
              ),
            ],
          ),
        ],
      );
}
