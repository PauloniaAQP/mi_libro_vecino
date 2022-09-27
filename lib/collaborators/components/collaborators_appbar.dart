import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_dialog.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';
import 'package:paulonia_utils/paulonia_utils.dart';

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
      actions: [
        Container(
          constraints: const BoxConstraints(maxWidth: 234),
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              pDialog(
                body: l10n.collaboratorsPageDialogLeaveBody,
                confirmLabel: l10n.collaboratorsPageDialogLeaveConfirm,
                context: context,
                onConfirm: () {
                  Navigator.of(context).pop();
                  context.read<CollaboratorCubit>().signOut().then((_) {
                    /// Here we make a delayed because last pop() needs
                    /// a little time to finish and paint the screen
                    Future<void>.delayed(const Duration(milliseconds: 100), () {
                      context.go(Routes.search);
                    });
                  });
                },
                title: l10n.collaboratorsPageDialogLeaveTitle,
              );
            },
            child: BlocBuilder<AppUserBloc, AppUserState>(
              builder: (context, state) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: PUtils.isOnTest()
                          ? null
                          : PCacheImage(
                              state.currentUser?.gsUrl ?? '',
                              enableInMemory: true,
                            ),
                      radius: 20,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      state.currentUser?.name ?? '',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: PColors.black,
                            fontSize: 14,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.expand_more,
                      color: PColors.black,
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
