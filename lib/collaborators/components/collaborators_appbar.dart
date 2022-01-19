import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class CollaboratorsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CollaboratorsAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppBar(
      title: Text(
        l10n.collaboratorsPageTitle,
        style: Theme.of(context).textTheme.button!.copyWith(
              color: PColors.black,
              fontSize: 18,
            ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 80,
      centerTitle: true,
      leadingWidth: 100,
      leading: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Image(
          image: AssetImage(Assets.logo),
          height: 40,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(Assets.testImg),
                  radius: 20,
                ),
                const SizedBox(width: 20),
                Text(
                  'Apellido y nombre',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: PColors.black,
                        fontSize: 14,
                      ),
                ),
                const SizedBox(width: 20),
                const Icon(
                  Icons.expand_more,
                  color: PColors.black,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
