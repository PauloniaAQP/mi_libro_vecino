import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/search/widgets/search_widget.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/constans/globals.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        leadingWidth: 180,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 11),
          child: Image(
            image: AssetImage(Assets.logoWithName),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (context.read<AppUserBloc>().state is AppUserAuthenticated) {
                if (!context.read<AppUserBloc>().state.isAdmin) {
                  context.go(Routes.collaborators);
                  return;
                } else {
                  AuthService.signOut();
                }
              }
              context.go(Routes.login);
            },
            child: Text(
              l10n.searchPageImLibraryButton,
              style: Theme.of(context).textTheme.subtitle1!.apply(
                    color: PColors.white,
                    fontWeightDelta: 1,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: ResponsiveBuilder(
              builder:
                  (BuildContext context, SizingInformation sizingInformation) {
                var newWidth = 158.0;

                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.mobile) {
                  newWidth = 50;
                }
                return Container(
                  width: newWidth,
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(PColors.white),
                    ),
                    onPressed: () async {
                      final uri = Uri.parse(Globals.webUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    child: ScreenTypeLayout(
                      mobile: const Image(
                        image: AssetImage(Assets.facebookLogo),
                        color: Colors.blue,
                        height: 35,
                      ),
                      desktop: Text(
                        l10n.searchPageFollowButton,
                        style: Theme.of(context).textTheme.subtitle1!.apply(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeightDelta: 1,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
            width: 800,
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 180,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      ResponsiveBuilder(
                        builder: (
                          BuildContext context,
                          SizingInformation sizingInformation,
                        ) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 9,
                                child: Text(
                                  l10n.searchPageTitle.substring(0, 14),
                                  style: sizingInformation.deviceScreenType ==
                                          DeviceScreenType.mobile
                                      ? Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .apply(
                                            color: PColors.white,
                                            fontSizeDelta: 2,
                                          )
                                      : Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .apply(
                                            color: PColors.white,
                                            fontSizeDelta: 2,
                                          ),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 80),
                              Expanded(
                                flex: 8,
                                child: Text(
                                  l10n.searchPageTitle.substring(14),
                                  style: sizingInformation.deviceScreenType ==
                                          DeviceScreenType.mobile
                                      ? Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .apply(
                                            color: PColors.white,
                                            fontSizeDelta: 2,
                                          )
                                      : Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .apply(
                                            color: PColors.white,
                                            fontSizeDelta: 2,
                                          ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Center(
                        child: Image.asset(
                          Assets.searchImg,
                          fit: BoxFit.contain,
                          width: 160,
                          height: 160,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  context.l10n.searchPageAfterTitle,
                  style: Theme.of(context).textTheme.subtitle1!.apply(
                        color: PColors.white,
                        fontWeightDelta: 1,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                SearchWidget()
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 55,
        color: Theme.of(context).colorScheme.primary,
        child: Stack(
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 180,
                ),
                child: Text(
                  l10n.searchPageFootpage,
                  style: Theme.of(context).textTheme.subtitle1!.apply(
                        color: PColors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {
                    if (context.read<AppUserBloc>().state
                        is AppUserAuthenticated) {
                      if (context.read<AppUserBloc>().state.isAdmin) {
                        context.go(Routes.admin);
                        return;
                      } else {
                        AuthService.signOut();
                      }
                    }
                    const queryAdmin = '?isAdmin=true';
                    GoRouter.of(context).go(Routes.login + queryAdmin);
                  },
                  child: Text(
                    l10n.searchPageAdminButton,
                    style: Theme.of(context).textTheme.subtitle1!.apply(
                          color: PColors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
