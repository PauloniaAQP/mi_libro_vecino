import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino_api/api_configuration.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';

class LocationsMap extends StatelessWidget {
  const LocationsMap({
    Key? key,
    required this.center,
    required this.currentLocation,
    required this.isLibraryInfo,
  }) : super(key: key);

  final Coordinates? center;
  final Coordinates? currentLocation;
  final bool isLibraryInfo;

  bool _areThereResults(LibrariesState state) {
    if (state.currentLibrary != null) {
      return true;
    } else if (state.libraries != null) {
      if (state.libraries!.isNotEmpty) {
        return true;
      }
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LibrariesCubit, LibrariesState>(
      builder: (context, state) {
        return Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: center != null
                    ? LatLng(
                        center!.latitude,
                        center!.longitude,
                      )
                    : null,
                zoom: 15,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: ApiConfiguration.mapsAPIUrl,
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    if (currentLocation != null)
                      Marker(
                        width: 80,
                        height: 80,
                        point: LatLng(
                          currentLocation!.latitude,
                          currentLocation!.longitude,
                        ),
                        builder: (ctx) => Image.asset(
                          Assets.locationIcon,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    if (!isLibraryInfo)
                      ...List.generate(
                        state.libraries!.length,
                        (index) => Marker(
                          width: 40,
                          height: 40,
                          point: LatLng(
                            state.libraries![index].location.latitude,
                            state.libraries![index].location.longitude,
                          ),
                          builder: (ctx) => Image.asset(
                            Assets.locationPinIcon,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      )
                    else if (state.currentLibrary != null)
                      Marker(
                        width: 40,
                        height: 40,
                        point: LatLng(
                          state.currentLibrary!.location.latitude,
                          state.currentLibrary!.location.longitude,
                        ),
                        builder: (ctx) => Image.asset(
                          Assets.locationPinIcon,
                          height: 50,
                          width: 50,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: !_areThereResults(state),
              child: Expanded(
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
              ),
            ),
          ],
        );
      },
    );
  }
}
