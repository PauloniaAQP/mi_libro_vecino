import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/admin/view/admin_page.dart';
import 'package:mi_libro_vecino/authentication/view/login_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/disabled_account_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/email_register_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/personal_name_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/register_error_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/waiting_page.dart';
import 'package:mi_libro_vecino/authentication/view/register_page.dart';
import 'package:mi_libro_vecino/collaborators/view/collaborators_page.dart';
import 'package:mi_libro_vecino/libraries/view/libraries_page.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/search/search.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';

abstract class AppRouter {
  static GoRouter get router => GoRouter(
        initialLocation: Routes.search,
        errorPageBuilder: (_, state) {
          return MaterialPage(
            child: Builder(
              builder: (context) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  context.go(Routes.search);
                });
                return const SearchPage();
              },
            ),
          );
        },
        routes: [
          GoRoute(
            path: Routes.search,
            pageBuilder: (context, state) => const MaterialPage(
              child: SearchPage(),
            ),
          ),
          GoRoute(
            path: Routes.libraries,
            pageBuilder: (context, state) {
              final libraryIdQuery = state.queryParams['id'];
              final searchQuery = state.queryParams['search'];
              return MaterialPage(
                child: LibrariesPage(
                  libraryIdQuery: libraryIdQuery,
                  searchQuery: searchQuery,
                ),
              );
            },
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
          GoRoute(
            path: Routes.login,
            pageBuilder: (context, state) {
              final isAdmin = state.queryParams['isAdmin'] == 'true';
              return MaterialPage(
                child: LoginPage(isAdmin: isAdmin),
              );
            },
          ),
          GoRoute(
            path: Routes.waiting,
            pageBuilder: (context, state) => const MaterialPage(
              child: WaitingPage(),
            ),
          ),
          GoRoute(
            path: Routes.errorRegister,
            pageBuilder: (context, state) => const MaterialPage(
              child: RegisterErrorPage(),
            ),
          ),
          GoRoute(
            path: Routes.disabledAccount,
            pageBuilder: (context, state) => const MaterialPage(
              child: DisabledAcountPage(),
            ),
          ),
          GoRoute(
            path: Routes.collaborators,
            pageBuilder: (context, state) => const MaterialPage(
              child: CollaboratorsPage(),
            ),
            redirect: (_) {
              if (AuthService.isLoggedIn()) {
                return '${Routes.collaborators}/${Routes.collaboratorsPersonal}';
              } else {
                return Routes.login;
              }
            },
            routes: [
              GoRoute(
                path: Routes.collaboratorsPersonal,
                redirect: (_) {
                  if (!AuthService.isLoggedIn()) return Routes.login;
                  return null;
                },
                pageBuilder: (context, state) => const MaterialPage(
                  child: CollaboratorsPage(),
                ),
              ),
              GoRoute(
                path: Routes.collaboratorsLibrary,
                redirect: (_) {
                  if (!AuthService.isLoggedIn()) return Routes.login;
                  return null;
                },
                pageBuilder: (context, state) => const MaterialPage(
                  child: CollaboratorsPage(index: 1),
                ),
              ),
            ],
          ),
          GoRoute(
            path: Routes.admin,
            pageBuilder: (context, state) => const MaterialPage(
              child: AdminPage(),
            ),
            redirect: (_) {
              if (AuthService.isLoggedIn()) {
                return '${Routes.admin}/${Routes.adminNewRequests}';
              }
              return Routes.login;
            },
            routes: [
              GoRoute(
                path: Routes.adminNewRequests,
                pageBuilder: (context, state) {
                  final libraryIdQuery = state.queryParams['id'];
                  return MaterialPage(
                    child: AdminPage(id: libraryIdQuery),
                  );
                },
              ),
              GoRoute(
                path: Routes.adminLibraries,
                pageBuilder: (context, state) {
                  final libraryIdQuery = state.queryParams['id'];
                  return MaterialPage(
                    child: AdminPage(index: 1, id: libraryIdQuery),
                  );
                },
              ),
            ],
          ),
        ],
      );
}
