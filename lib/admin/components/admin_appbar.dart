import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class AdminAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AdminAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 80,
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
                  'Josefina',
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
