import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/admin/components/admin_library_card.dart';
import 'package:mi_libro_vecino/admin/components/admin_search_widget.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino_api/models/library_model.dart';
import 'package:mi_libro_vecino_api/models/user_model.dart';

class LibrariesCardList extends StatefulWidget {
  const LibrariesCardList({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<LibrariesCardList> createState() => _LibrariesCardListState();
}

class _LibrariesCardListState extends State<LibrariesCardList> {
  final _scrollController = ScrollController();

  bool _isLoadingPagination = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoadingPagination &&
          widget.index == 1 &&
          !context.read<AdminCubit>().isAllLibraries) {
        setState(() {
          _isLoadingPagination = true;
        });
        await context.read<AdminCubit>().loadMoreLibraries();
        setState(() {
          _isLoadingPagination = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        List<LibraryModel> libraries;
        if (widget.index == 0) {
          libraries = state.pendingLibraries ?? [];
        } else {
          if (state.isSearching) {
            libraries = state.searchLibraries ?? [];
          } else {
            libraries = state.acceptedLibraries ?? [];
          }
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 50,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                widget.index == 0
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
                  visible: widget.index == 1,
                  child: const AdminSearchWidget(),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      ...List.generate(libraries.length, (index) {
                        return FutureBuilder<UserModel?>(
                            future: context
                                .read<AdminCubit>()
                                .getUser(libraries[index].ownerId),
                            builder: (context, async) {
                              if (async.connectionState ==
                                      ConnectionState.done &&
                                  async.hasData) {
                                return AdminLibraryCard(
                                  labels: libraries[index].services +
                                      libraries[index].tags,
                                  subtitle: async.data?.name ?? '',
                                  title: libraries[index].name,
                                  gsUrl: libraries[index].gsUrl,
                                  onTap: () {
                                    final route = '''
${GoRouter.of(context).location}?id=${libraries[index].id}''';
                                    GoRouter.of(context).go(route);
                                  },
                                );
                              }
                              return AdminLibraryCard(
                                labels: libraries[index].services +
                                    libraries[index].tags,
                                subtitle: '',
                                title: libraries[index].name,
                                gsUrl: libraries[index].gsUrl,
                                onTap: () {
                                  final route = '''
${GoRouter.of(context).location}?id=${libraries[index].id}''';
                                  GoRouter.of(context).go(route);
                                },
                              );
                            });
                      }),
                      if (_isLoadingPagination && widget.index == 1)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
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
