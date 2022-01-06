import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/register/components/dot_navigation.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/register/view/pages/email_register_page.dart';
import 'package:mi_libro_vecino/register/view/pages/library_categories_page.dart';
import 'package:mi_libro_vecino/register/view/pages/library_information_page.dart';
import 'package:mi_libro_vecino/register/view/pages/library_map_page.dart';
import 'package:mi_libro_vecino/register/view/pages/library_photo_page.dart';
import 'package:mi_libro_vecino/register/view/pages/personal_name_page.dart';
import 'package:mi_libro_vecino/register/view/pages/personal_photo_page.dart';
import 'package:mi_libro_vecino/register/view/pages/waiting_page.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
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
    const imgPath = 'assets/images/library.jpeg';
    super.build(context);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    imgPath,
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color(0xE624204A),
                    BlendMode.darken,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(80),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Image(
                            image: AssetImage(Assets.logo),
                            height: 66,
                          ),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        Text(
                          context.l10n.registerPageQuote,
                          style: Theme.of(context).textTheme.headline1!.apply(
                                color: PColors.white,
                              ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        SizedBox(
                          height: 56,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              context.l10n.registerPageLearnMoreButton,
                              style:
                                  Theme.of(context).textTheme.subtitle1!.apply(
                                        color: PColors.white,
                                        fontWeightDelta: 1,
                                        fontSizeDelta: 2,
                                      ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (_, state) {
                return CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
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
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
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
                                      const Spacer(),
                                      SizedBox(
                                        height: 56,
                                        width: 200,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<RegisterCubit>()
                                                .nextPage();
                                          },
                                          child: Text(
                                            context.l10n
                                                .registerPageRegisterButton,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
