import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/admin/components/admin_appbar.dart';
import 'package:mi_libro_vecino/admin/components/admin_expand_menu.dart';
import 'package:mi_libro_vecino/admin/components/libraries_card_list.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/admin/view/pages/admin_library_information_page.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/selector_button.dart';
import 'package:mi_libro_vecino_api/services/auth_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminPage extends StatefulWidget {
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
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (context.read<AppUserBloc>().state.status ==
          AuthenticationStatus.authenticated) {
        if (context.read<AppUserBloc>().state.isAdmin) {
          GoRouter.of(context).go(Routes.admin);
        } else {
          GoRouter.of(context).go(Routes.collaborators);
        }
      }
    });
  }

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
                        child: ResponsiveBuilder(
                          builder: (
                            BuildContext context,
                            SizingInformation sizingInformation,
                          ) {
                            return Text(
                              l10n.adminPageCollaborators,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontSize:
                                        sizingInformation.deviceScreenType ==
                                                DeviceScreenType.desktop
                                            ? 28
                                            : 16,
                                  ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      SelectorButton(
                        isSelected: 0 == widget.index,
                        onTap: () {
                          const route =
                              '${Routes.admin}/${Routes.adminNewRequests}';
                          GoRouter.of(context).go(route);
                        },
                        title: l10n.adminPageNewRequests,
                      ),
                      SelectorButton(
                        isSelected: 1 == widget.index,
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
                child: BlocBuilder<AdminCubit, AdminState>(
                  builder: (context, state) {
                    if (state.acceptedLibraries == null) {
                      context.read<AdminCubit>().fillData();
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (widget.id == null) {
                      return LibrariesCardList(index: widget.index);
                    } else {
                      return AdminLibraryInformationPage(
                        index: widget.index,
                        id: widget.id!,
                      );
                    }
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
