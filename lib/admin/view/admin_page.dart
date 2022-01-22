import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/admin/components/admin_appbar.dart';
import 'package:mi_libro_vecino/admin/components/admin_expand_menu.dart';
import 'package:mi_libro_vecino/admin/components/libraries_card_list.dart';
import 'package:mi_libro_vecino/admin/view/pages/admin_library_information_page.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/selector_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({
    Key? key,
    this.index = 0,
    this.id,
  }) : super(key: key);

  /// If the index is 0, we are in the new request section
  /// and in other hand, index 1 is for old collaborators
  final int index;
  final String? id;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Stack(
      children: [
        Scaffold(
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
                        child: Text(
                          l10n.adminPageCollaborators,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 28),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SelectorButton(
                        isSelected: 0 == index,
                        onTap: () {
                          const route =
                              '${Routes.admin}/${Routes.adminNewRequests}';
                          GoRouter.of(context).go(route);
                        },
                        title: l10n.adminPageNewRequests,
                      ),
                      SelectorButton(
                        isSelected: 1 == index,
                        onTap: () {
                          const route =
                              '${Routes.admin}/${Routes.adminLibraries}';
                          GoRouter.of(context).go(route);
                        },
                        title: l10n.adminPageRegistered,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Builder(
                  builder: (context) {
                    if (id != null) {
                      return AdminLibraryInformationPage(
                        index: index,
                        id: id ?? '',
                      );
                    }
                    return LibrariesCardList(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.topRight,
          child: AdminExpandMenu(),
        )
      ],
    );
  }
}
