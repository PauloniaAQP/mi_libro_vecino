import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_dialog.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';

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
            onTap: () {
              pDialog(
                body: l10n.collaboratorsPageDialogLeaveBody,
                confirmLabel: l10n.collaboratorsPageDialogLeaveConfirm,
                context: context,
                onConfirm: () {
                  context.read<CollaboratorCubit>().signOut().then((_) {
                    context.go(Routes.login);
                  });
                },
                title: l10n.collaboratorsPageDialogLeaveTitle,
              );
            },
            child: BlocBuilder<CollaboratorCubit, CollaboratorState>(
              builder: (context, state) {
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: PCacheImage(state.user?.gsUrl ?? ''),
                      radius: 20,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      state.user?.name ?? '',
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
