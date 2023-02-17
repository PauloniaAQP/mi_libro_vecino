import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/admin/components/admin_appbar.dart';
import 'package:mi_libro_vecino/admin/components/admin_expand_menu.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/collaborators/view/pages/collaborator_library_info_page.dart';
import 'package:mi_libro_vecino/collaborators/view/pages/collaborator_personal_info_page.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_dialog.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/selector_button.dart';

import 'package:responsive_builder/responsive_builder.dart';

class CollaboratorsPage extends StatefulWidget {
  const CollaboratorsPage({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  final int index;
  static const pages = [
    CollaboratorPersonalInfoPage(),
    CollaboratorLibraryInfoPage(),
  ];

  @override
  State<CollaboratorsPage> createState() => _CollaboratorsPageState();
}

class _CollaboratorsPageState extends State<CollaboratorsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Stack(
      children: [
        Scaffold(
          key: const Key('collaborators_page_scaffold'),
          appBar: const AdminAppBar(),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 34),
                        child: ResponsiveBuilder(
                          builder: (
                            BuildContext context,
                            SizingInformation sizingInformation,
                          ) {
                            return Text(
                              l10n.collaboratorsPageTitle,
                              style: sizingInformation.deviceScreenType ==
                                      DeviceScreenType.desktop
                                  ? Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 28)
                                  : Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 16),
                            );
                          },
                        ),
                      ),
                      SelectorButton(
                        isSelected: 0 == widget.index,
                        onTap: () {
                          const route =
                              '${Routes.collaborators}/${Routes.collaboratorsPersonal}';
                          GoRouter.of(context).go(route);
                        },
                        title: l10n.collaboratorsPagePersonalInfo,
                      ),
                      SelectorButton(
                        isSelected: 1 == widget.index,
                        onTap: () {
                          const route =
                              '${Routes.collaborators}/${Routes.collaboratorsLibrary}';
                          GoRouter.of(context).go(route);
                        },
                        title: '${l10n.collaboratorsPageRoleInfo}biblioteca',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: BlocBuilder<CollaboratorCubit, CollaboratorState>(
                  // buildWhen: (previous, current) =>
                  //     previous.library != current.library,
                  builder: (_, state) {
                    if (state.library == null) {
                      context.read<CollaboratorCubit>().fillData();
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CollaboratorsPage.pages[widget.index];
                  },
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: AdminExpandMenu(
            onLogout: () {
              if (context.read<CollaboratorCubit>().libraryInfoWasTouched ||
                  context.read<CollaboratorCubit>().personalInfoWasTouched) {
                pDialog(
                  body: l10n.collaboratorsPageDialogLeaveBody,
                  confirmLabel: l10n.collaboratorsPageDialogLeaveConfirm,
                  context: context,
                  onConfirm: () {
                    Navigator.of(context).pop();
                    context.read<CollaboratorCubit>().signOut().then((_) {
                      /// Here we make a delayed because last pop() needs
                      /// a little time to finish and paint the screen
                      Future<void>.delayed(const Duration(milliseconds: 100),
                          () {
                        context.go(Routes.search);
                      });
                    });
                  },
                  title: l10n.collaboratorsPageDialogLeaveTitle,
                );
              } else {
                context.read<CollaboratorCubit>().signOut().then((_) {
                  /// Here we make a delayed because last pop() needs
                  /// a little time to finish and paint the screen
                  Future<void>.delayed(const Duration(milliseconds: 100), () {
                    context.go(Routes.search);
                  });
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
