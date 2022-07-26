import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino_api/api_configuration.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';

class LocationMap extends StatelessWidget {
  const LocationMap({
    Key? key,
    required this.center,
    required this.point,
    this.onPositionChanged,
  }) : super(key: key);

  final Coordinates center;
  final Coordinates point;
  final void Function(MapPosition, bool)? onPositionChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(center.latitude, center.longitude),
            zoom: 15,
            maxZoom: 18.25,
            minZoom: 5,
            onPositionChanged: onPositionChanged,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: ApiConfiguration.mapsAPIUrl,
              subdomains: ['a', 'b', 'c'],
            ),
          ],
        ),
        Image.asset(
          Assets.locationPinIcon,
          height: 45,
        ),
      ],
    );
  }
}
