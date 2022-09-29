import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:mi_libro_vecino/admin/components/bottom_buttons.dart';
import 'package:mi_libro_vecino/admin/components/info_field.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/category_chip.dart';
import 'package:mi_libro_vecino_api/models/library_model.dart';
import 'package:mi_libro_vecino_api/models/user_model.dart';
import 'package:mi_libro_vecino_api/services/geo_service.dart'
    if (dart.library.io) 'package:mi_libro_vecino_api/services/test_geo_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';
import 'package:paulonia_utils/paulonia_utils.dart';

class AdminLibraryInformationPage extends StatefulWidget {
  const AdminLibraryInformationPage({
    Key? key,
    required this.index,
    required this.id,
  }) : super(key: key);

  final int index;
  final String id;

  @override
  State<AdminLibraryInformationPage> createState() =>
      _AdminLibraryInformationPageState();
}

class _AdminLibraryInformationPageState
    extends State<AdminLibraryInformationPage> {
  UserModel? user;

  LibraryModel? library;
  bool isLoading = true;

  Future<void> getModels(BuildContext context) async {
    try {
      await context
          .read<AdminCubit>()
          .getLibrary(widget.id)
          .then((value) async {
        library = value;
        await context
            .read<AdminCubit>()
            .getUser(value?.ownerId ?? '')
            .then((value) {
          user = value;
        });
      });
    } catch (e) {
      log('Usuario no encontrado');
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getModels(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * 0.05;
    final l10n = context.l10n;
    const defaultTime = TimeOfDay(hour: 00, minute: 00);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _width),
      child: Scaffold(
        key: const Key('admin_info_page_scaffold'),
        appBar: AppBar(
          key: const Key('admin_info_page_app_bar'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            splashRadius: 28,
            onPressed: () {
              if (widget.index == 0) {
                GoRouter.of(context).go(Routes.admin);
              } else {
                GoRouter.of(context)
                    .go('${Routes.admin}/${Routes.adminLibraries}');
              }
            },
            icon: const Image(
              image: AssetImage(Assets.backIcon),
              color: PColors.black,
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (library == null || user == null && !isLoading) {
              return const Center(
                child: Text('No se encontró la biblioteca'),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: _width),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.registerPagePersonalInformationTitle,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Container(
                              key: const Key(
                                'admin_info_page_image_container',
                              ),
                              height: 232,
                              width: 232,
                              decoration: BoxDecoration(
                                image: PUtils.isOnTest()
                                    ? null
                                    : DecorationImage(
                                        image: PCacheImage(user?.gsUrl ?? ''),
                                        fit: BoxFit.cover,
                                      ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: _width),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              InfoField(
                                label: l10n.registerPagePersonalNameLabel,
                                text: user?.name ?? '',
                              ),
                              InfoField(
                                label: l10n.registerPagePersonalPhoneLabel,
                                text: user?.phone ?? '',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 90),
                    Text(
                      l10n.registerPageLibraryInformationTitle +
                          getStringRolByType(
                            library?.type ?? LibraryType.values[1],
                            l10n,
                          ),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Container(
                              height: 232,
                              width: 232,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: PCacheImage(library?.gsUrl ?? ''),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: _width),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoField(
                                label: l10n.registerPageLibraryNameLabel,
                                text: library?.name ?? '',
                              ),
                              InfoField(
                                label: l10n.registerPageLibraryWebLabel,
                                text: library?.website == 'null'
                                    ? ''
                                    : library?.website ?? '',
                              ),
                              InfoField(
                                label: l10n.registerPageLibraryDescriptionLabel,
                                text: library?.description ?? '',
                                maxLines: 5,
                              ),
                              InfoField(
                                label: l10n.libraryInfoTimetable,
                                text:
                                    '''${ApiUtils.timeOfDayToString(library?.openingHour ?? defaultTime)} - ${ApiUtils.timeOfDayToString(library?.closingHour ?? defaultTime)}''',
                              ),
                              InfoField(
                                label: l10n.registerPageLibraryRolLabel,
                                text: getStringRolByType(
                                  library?.type ?? LibraryType.bookshop,
                                  l10n,
                                ),
                              ),
                              InfoField(
                                label: l10n.adminPagePhysicalAddress,
                                text: library?.address ?? '',
                              ),
                              FutureBuilder<String?>(
                                future: GeoService.getAddress(
                                  library?.location,
                                ),
                                builder: (context, snapshot) {
                                  return InfoField(
                                    label: l10n.adminPageMapLocation,
                                    text: snapshot.data ?? '',
                                    maxLines: 2,
                                    suffixIcon: (snapshot.connectionState !=
                                            ConnectionState.done)
                                        ? const CircularProgressIndicator()
                                        : Icon(
                                            Icons.check,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                  );
                                },
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.38,
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.5,
                                  minHeight: 200,
                                ),
                                child: FlutterMap(
                                  options: MapOptions(
                                    center: LatLng(
                                      library?.location.latitude ?? 0,
                                      library?.location.longitude ?? 0,
                                    ),
                                    zoom: 15,
                                    minZoom: 5,
                                    maxZoom: 18.25,
                                    allowPanning: false,
                                    allowPanningOnScrollingParent: false,
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
                                          width: 40,
                                          height: 40,
                                          point: LatLng(
                                            library?.location.latitude ?? 0,
                                            library?.location.longitude ?? 0,
                                          ),
                                          builder: (ctx) => const Image(
                                            image: AssetImage(
                                              Assets.locationPinIcon,
                                            ),
                                            height: 79,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 12,
                                ),
                                child: Text(
                                  l10n.registerPageServicesTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: PColors.black,
                                      ),
                                ),
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: List.generate(
                                  library?.services.length ?? 0,
                                  (index) {
                                    return CategoryChip(
                                      label: library?.services[index] ?? '',
                                      isSelected: false,
                                    );
                                  },
                                ),
                              ),
                              InfoField(
                                label: l10n.adminPagePersonalLabels,
                                text: library?.tags.join(', ') ?? '',
                                maxLines: 3,
                              ),
                              const SizedBox(height: 70),
                              BottomButtons(
                                id: widget.id,
                                index: widget.index,
                              ),
                              const SizedBox(height: 70),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
