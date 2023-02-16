import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
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
import 'package:mi_libro_vecino/ui_utils/general_widgets/future_with_loading.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const RegisterPageView(),
    );
  }
}

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({Key? key}) : super(key: key);

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
  RegisterPageViewState createState() => RegisterPageViewState();
}

class RegisterPageViewState extends State<RegisterPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = context.l10n;
    return Scaffold(
      body: ScreenTypeLayout(
        mobile: Column(
          children: [
            Expanded(
              child: BlocListener<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state.status == RegisterStatus.error) {
                    context.read<AppUserBloc>().add(const AppUserRegistered());
                    context.go(Routes.errorRegister);
                  }
                  if (state.status == RegisterStatus.success) {
                    context.read<AppUserBloc>().add(const AppUserRegistered());
                    context.go(Routes.waiting);
                  }
                },
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          fillOverscroll: true,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.1,
                              horizontal: 50,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: RegisterPageView.pages[state.index],
                                ),
                                Visibility(
                                  visible: state.index > 0 && state.index < 6,
                                  child: DotNavigation(
                                    /// Index and length are-2 because the first
                                    /// page and last are not shown in the dot
                                    /// navigation
                                    index: state.index - 1,
                                    length: RegisterPageView.pages.length - 3,
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
                                                context.read<AppUserBloc>().add(
                                                    const AppUserRegistering());
                                                futureWithLoading(
                                                  context
                                                      .read<RegisterCubit>()
                                                      .onRegisterAndContinue(),
                                                  context,
                                                );
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
            ),
          ],
        ),
        desktop: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.error) {
              context.read<AppUserBloc>().add(const AppUserRegistered());
              context.go(Routes.errorRegister);
            }
            if (state.status == RegisterStatus.success) {
              context.read<AppUserBloc>().add(const AppUserRegistered());
              context.go(Routes.waiting);
            }
          },
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: QuotesPage(
                    imagesPath: const [
                      Assets.register1Img,
                      Assets.register2Img,
                      Assets.register3Img,
                      Assets.register4Img,
                      Assets.register5Img,
                      Assets.register6Img,
                      Assets.register7Img,
                    ],
                    index: state.index,
                    alignment: state.index == 3
                        ? Alignment.centerRight
                        : Alignment.center,
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        fillOverscroll: true,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.1,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: RegisterPageView.pages[state.index],
                              ),
                              Visibility(
                                visible: state.index > 0 && state.index < 6,
                                child: DotNavigation(
                                  /// Index and length are 2 because the first
                                  /// page and last are not shown in the dot
                                  /// navigation
                                  index: state.index - 1,
                                  length: RegisterPageView.pages.length - 3,
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
                                              context.read<AppUserBloc>().add(
                                                    const AppUserRegistering(),
                                                  );
                                              futureWithLoading(
                                                context
                                                    .read<RegisterCubit>()
                                                    .onRegisterAndContinue(),
                                                context,
                                              );
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
