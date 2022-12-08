import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_appbar.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_list.dart';
import 'package:mi_libro_vecino/libraries/components/library_info.dart';
import 'package:mi_libro_vecino/libraries/components/locations_map.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mi_libro_vecino/search/widgets/search_widget.dart';
import 'package:mi_libro_vecino_api/models/library_model.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LibrariesPage extends StatelessWidget {
  const LibrariesPage({
    Key? key,
    this.searchQuery,
    this.libraryIdQuery,
  }) : super(key: key);

  final String? searchQuery;
  final String? libraryIdQuery;

  @override
  Widget build(BuildContext context) {
    if (libraryIdQuery != null) {
      context.read<LibrariesCubit>().getLibrary(libraryIdQuery!);
    } else if (searchQuery != null) {
      context.read<LibrariesCubit>().loadLibraries(searchQuery!);
    }
    return Scaffold(
      appBar: const LibrariesAppBar(),
      body: BlocBuilder<LibrariesCubit, LibrariesState>(
        builder: (context, state) {
          if (state is LibrariesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ScreenTypeLayout(
            mobile: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LibraryWidgets(
                  libraryIdQuery: libraryIdQuery,
                  searchQuery: searchQuery,
                  currentLibrary: state.currentLibrary,
                  flex: 2,
                ),
                MapWidgets(libraryIdQuery: libraryIdQuery),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LibraryWidgets(
                  libraryIdQuery: libraryIdQuery,
                  searchQuery: searchQuery,
                  currentLibrary: state.currentLibrary,
                  flex: 1,
                ),
                MapWidgets(libraryIdQuery: libraryIdQuery),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MapWidgets extends StatelessWidget {
  const MapWidgets({
    Key? key,
    required this.libraryIdQuery,
  }) : super(key: key);

  final String? libraryIdQuery;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 30, 42),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BlocBuilder<LibrariesCubit, LibrariesState>(
            builder: (context, state) {
              final currentLocation =
                  context.read<AppUserBloc>().state.currentLocation;
              Coordinates? center;
              if (libraryIdQuery != null) {
                center = state.currentLibrary?.location;
              } else {
                center = ApiUtils.getCenterFromCoordinates(
                  List.generate(
                    state.libraries?.length ?? 0,
                    (index) => state.libraries![index].location,
                  ),
                );
              }
              return LocationsMap(
                center: center,
                currentLocation: currentLocation,
                isLibraryInfo: libraryIdQuery != null,
              );
            },
          ),
        ),
      ),
    );
  }
}

class LibraryWidgets extends StatelessWidget {
  const LibraryWidgets(
      {Key? key,
      required this.libraryIdQuery,
      required this.searchQuery,
      required this.currentLibrary,
      required this.flex})
      : super(key: key);

  final String? libraryIdQuery;
  final String? searchQuery;
  final LibraryModel? currentLibrary;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Stack(
          children: [
            if (libraryIdQuery != null)
              InfomationLibrary(
                library: currentLibrary,
              )
            else
              LibrariesList(
                searchQuery: searchQuery,
              ),
            SearchWidget(),
          ],
        ),
      ),
    );
  }
}
