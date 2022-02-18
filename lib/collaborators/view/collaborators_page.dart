import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/collaborators/components/collaborators_appbar.dart';
import 'package:mi_libro_vecino/collaborators/view/pages/collaborator_library_info_page.dart';
import 'package:mi_libro_vecino/collaborators/view/pages/collaborator_personal_info_page.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/selector_button.dart';

class CollaboratorsPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: const CollaboratorsAppBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 34),
                    child: Text(
                      l10n.collaboratorsPageTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 28),
                    ),
                  ),
                  SelectorButton(
                    isSelected: 0 == index,
                    onTap: () {
                      const route =
                          '${Routes.collaborators}/${Routes.collaboratorsPersonal}';
                      GoRouter.of(context).go(route);
                    },
                    title: l10n.collaboratorsPagePersonalInfo,
                  ),
                  SelectorButton(
                    isSelected: 1 == index,
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
            child: pages[index],
          )
        ],
      ),
    );
  }
}
