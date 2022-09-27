import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_appbar.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_list.dart';
import 'package:mi_libro_vecino/libraries/components/library_info.dart';
import 'package:mi_libro_vecino/libraries/components/locations_map.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mi_libro_vecino/search/widgets/search_widget.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';

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
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Stack(
                    children: [
                      if (libraryIdQuery != null)
                        InfomationLibrary(
                          library: state.currentLibrary,
                        )
                      else
                        LibrariesList(
                          searchQuery: searchQuery,
                        ),
                      SearchWidget(),
                    ],
                  ),
                ),
              ),
              Expanded(
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
              ),
            ],
          );
        },
      ),
    );
  }
}
