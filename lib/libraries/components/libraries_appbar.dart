import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/constans/globals.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class LibrariesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LibrariesAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppBar(
      leadingWidth: 120,
      backgroundColor: PColors.white,
      leading: InkWell(
        onTap: () => context.go(Routes.search),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 22),
          child: Image(
            image: AssetImage(Assets.logo),
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () => context.go(Routes.login),
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Center(
            child: Text(
              l10n.searchPageImLibraryButton,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
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
                  onPressed: () async {
                    final uri = Uri.parse(Globals.webUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  child: ScreenTypeLayout(
                    mobile: const Image(
                      image: AssetImage(Assets.facebookLogo),
                      height: 30,
                    ),
                    desktop: Text(
                      l10n.searchPageFollowButton,
                      style: Theme.of(context).textTheme.subtitle1!.apply(
                            color: PColors.white,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
