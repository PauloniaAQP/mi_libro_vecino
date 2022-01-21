import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/admin/components/admin_appbar.dart';
import 'package:mi_libro_vecino/admin/components/admin_library_card.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/selector_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  /// If the index is 0, we are in the new request section
  /// and in other hand, index 1 is for old collaborators
  final int index;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
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
                      const route = '${Routes.admin}/${Routes.adminLibraries}';
                      GoRouter.of(context).go(route);
                    },
                    title: l10n.adminPageCollaborators,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 67,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    index == 0
                        ? l10n.adminPageNewRequests
                        : l10n.adminPageCollaborators,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontSize: 20,
                          color: PColors.black,
                        ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        return AdminLibraryCard(
                          labels: ['label1'],
                          name: 'Holaaa',
                          onContact: () {},
                          title: 'asdasdasd',
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
