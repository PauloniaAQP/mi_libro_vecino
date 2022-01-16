import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/authentication/components/dot_navigation.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/authentication/view/pages/email_register_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/library_categories_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/library_information_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/library_map_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/library_photo_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/personal_name_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/personal_photo_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/quotes_page.dart';
import 'package:mi_libro_vecino/authentication/view/pages/waiting_page.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const pages = [
    EmailRegisterPage(),
    PersonalNamePage(),
    PersonalPhoto(),
    LibraryInformationPage(),
    LibraryCategoriesPage(),
    LibraryMapPage(),
    LibraryPhotoPage(),
    WaitingPage(),
  ];

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = context.l10n;
    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            child: QuotesPage(),
          ),
          Expanded(
            child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (_, state) {
                return CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      // hasScrollBody: false,
                      fillOverscroll: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 80,
                          horizontal: 100,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: RegisterPage.pages[state.index],
                            ),
                            Visibility(
                              visible: state.index > 0 && state.index < 6,
                              child: DotNavigation(
                                /// Index and length are -2 because the first
                                /// page and last are not shown in the dot
                                /// navigation
                                index: state.index - 1,
                                length: RegisterPage.pages.length - 3,
                                onTapBack: () {
                                  context.read<RegisterCubit>().backPage();
                                },
                                onTapNext: () {
                                  context.read<RegisterCubit>().nextPage();
                                },
                              ),
                            ),
                            Visibility(
                              visible: state.index == 6,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width: 55,
                                    child: IconButton(
                                      onPressed: () {
                                        context
                                            .read<RegisterCubit>()
                                            .backPage();
                                      },
                                      icon: Image.asset(
                                        Assets.backIcon,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SizedBox(
                                        height: 56,
                                        width: 200,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            GoRouter.of(context)
                                                .go(Routes.waiting);
                                          },
                                          child: Text(
                                            l10n.registerPageRegisterButton,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
