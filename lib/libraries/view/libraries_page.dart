import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_appbar.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_list.dart';
import 'package:mi_libro_vecino/libraries/components/library_info.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mi_libro_vecino/search/widgets/search_widget.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

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
    final l10n = context.l10n;

    return Scaffold(
      appBar: const LibrariesAppBar(),
      body: BlocBuilder<LibrariesCubit, LibrariesState>(
        builder: (context, state) {
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
                          libraryId: libraryIdQuery ?? '',
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
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FlutterMap(
                                options: MapOptions(
                                  center: LatLng(-16.39, -71.53),
                                  zoom: 15,
                                ),
                                layers: [
                                  TileLayerOptions(
                                    urlTemplate:
                                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    subdomains: ['a', 'b', 'c'],
                                  ),
                                  MarkerLayerOptions(
                                    markers: [
                                      Marker(
                                        width: 80,
                                        height: 80,
                                        point: LatLng(-16.39, -71.53),
                                        builder: (ctx) => Image.asset(
                                          Assets.locationIcon,
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (searchQuery != null && state.libraries!.isEmpty)
                              Expanded(
                                child: Container(
                                  color: const Color(
                                    0xBB5D5D5D,
                                  ),
                                  child: Center(
                                    child: Text(
                                      l10n.librariesListPageNotFoundResults,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            else
                              const SizedBox(),
                          ],
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
