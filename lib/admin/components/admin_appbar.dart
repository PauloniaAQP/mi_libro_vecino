import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 80,
      leadingWidth: 100,
      leading: InkWell(
        onTap: () => context.go(Routes.search),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Image(
            image: AssetImage(Assets.logo),
            height: 40,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
