import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/libraries/components/library_card.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';

class LibrariesList extends StatefulWidget {
  const LibrariesList({
    Key? key,
    this.searchQuery,
  }) : super(key: key);

  final String? searchQuery;

  @override
  State<LibrariesList> createState() => _LibrariesListState();
}

class _LibrariesListState extends State<LibrariesList> {
  final _controller = ScrollController();

  bool _isLoadingPagination = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() async {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
          !_isLoadingPagination &&
          !context.read<LibrariesCubit>().isAllLibraries) {
        setState(() {
          _isLoadingPagination = true;
        });
        await context
            .read<LibrariesCubit>()
            .loadMoreLibraries(widget.searchQuery!);
        setState(() {
          _isLoadingPagination = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibrariesCubit, LibrariesState>(
      builder: (context, state) {
        return Column(
          key: const Key('librariesListKey'),
          children: [
            /// This space is for the search bar
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${state.libraries?.length ?? ""} resultados',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                controller: _controller,
                children: [
                  ...List.generate(
                    state.libraries?.length ?? 0,
                    (index) {
                      final labels = (state.libraries?[index].services ?? []) +
                          (state.libraries?[index].tags ?? []);
                      return LibraryCard(
                        gsUrl: state.libraries?[index].gsUrl ?? '',
                        subtitle: state.libraries?[index].address ?? '',
                        title: state.libraries?[index].name ?? '',
                        labels: labels,
                        onTap: () => context.go(
                          '''${GoRouter.of(context).location}&id=${state.libraries?[index].id}''',
                        ),
                      );
                    },
                  ),
                  if (_isLoadingPagination)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
