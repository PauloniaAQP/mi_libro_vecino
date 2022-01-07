import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class LibrariesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LibrariesAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppBar(
      leadingWidth: 120,
      backgroundColor: PColors.whiteBackground,
      leading: const Padding(
        padding: EdgeInsets.symmetric(vertical: 22),
        child: Image(
          image: AssetImage(Assets.logo),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            l10n.searchPageImLibraryButton,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Container(
            width: 158,
            height: 40,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                l10n.searchPageFollowButton,
                style: Theme.of(context).textTheme.subtitle1!.apply(
                      color: PColors.white,
                      fontWeightDelta: 1,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
