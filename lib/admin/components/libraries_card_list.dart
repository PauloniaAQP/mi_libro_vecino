import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/admin/components/admin_library_card.dart';
import 'package:mi_libro_vecino/admin/components/admin_search_widget.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class LibrariesCardList extends StatelessWidget {
  const LibrariesCardList({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 50,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                index == 0
                    ? l10n.adminPageNewRequests
                    : l10n.adminPageRegistered,
                style: Theme.of(context).textTheme.button!.copyWith(
                      fontSize: 20,
                      color: PColors.black,
                    ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 67,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: index == 1,
                  child: const AdminSearchWidget(),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return AdminLibraryCard(
                        labels: const ['label1'],
                        name: 'Holaaa',
                        onContact: () {},
                        title: 'asdasdasd',
                        onTap: () {
                          final route =
                              '${GoRouter.of(context).location}?id=as';
                          GoRouter.of(context).go(route);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
