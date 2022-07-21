import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_dialog.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_simple_dialog.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key? key,
    required this.index,
    required this.id,
  }) : super(key: key);

  final int index;
  final String id;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return (index == 0)
        ? Column(
            children: [
              Center(
                child: Container(
                  height: 56,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AdminCubit>().acceptLibrary(id).then(
                            (value) => context.go(Routes.admin),
                          );
                    },
                    child: Text(l10n.accept),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: TextButton(
                  onPressed: () {
                    final confirmLabel =
                        l10n.adminPageDialogRejectRequestConfirm;
                    pDialog(
                      body: l10n.adminPageDialogRejectRequestBody,
                      confirmLabel: confirmLabel,
                      context: context,
                      onConfirm: () {
                        context
                            .read<AdminCubit>()
                            .rejectLibrary(id)
                            .then((value) {
                          Navigator.pop(context);
                          Future.delayed(const Duration(milliseconds: 100), () {
                            if (value) {
                              context.go(
                                '${Routes.admin}/${Routes.adminNewRequests}',
                              );
                            } else {
                              pSimpleDialog(
                                title: 'Error',
                                body: 'Algo salió mal, intenta de nuevo',
                                context: context,
                              );
                            }
                          });
                        });
                      },
                      title: l10n.adminPageDialogRejectRequestTitle,
                    );
                  },
                  child: Text(
                    l10n.reject,
                    style: const TextStyle(
                      color: PColors.red,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: TextButton(
              key: const Key(
                'admin_info_remove_library_button',
              ),
              onPressed: () {
                pDialog(
                  body: l10n.adminPageDialogRemoveLibraryBody,
                  confirmLabel: l10n.adminPageDialogRemoveLibraryConfirm,
                  context: context,
                  onConfirm: () {
                    context.read<AdminCubit>().removeLibrary(id).then((value) {
                      Navigator.pop(context);
                      if (value) {
                        context.go('${Routes.admin}/${Routes.adminLibraries}');
                      } else {
                        pSimpleDialog(
                          title: 'Error',
                          body: 'Algo salió mal, intenta de nuevo',
                          context: context,
                        );
                      }
                    });
                  },
                  title: l10n.adminPageDialogRemoveLibraryTitle,
                );
              },
              child: Text(
                l10n.adminPageRemoveLibrary,
                style: const TextStyle(color: PColors.red),
              ),
            ),
          );
  }
}
