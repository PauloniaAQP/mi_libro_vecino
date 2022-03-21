import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mi_libro_vecino/admin/components/info_field.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/category_chip.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_dialog.dart';

class AdminLibraryInformationPage extends StatelessWidget {
  const AdminLibraryInformationPage({
    Key? key,
    required this.index,
    required this.id,
  }) : super(key: key);

  final int index;
  final String id;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * 0.05;
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _width),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          // TODO(oscarnar): For future, now pop() behavior is different
          // from the default
          // leading: IconButton(
          //   splashRadius: 28,
          //   onPressed: () {
          //     GoRouter.of(context).pop();
          //   },
          //   icon: const Image(
          //     image: AssetImage(Assets.backIcon),
          //     color: PColors.black,
          //   ),
          // ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: _width),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            image: const DecorationImage(
                              image: AssetImage(Assets.testImg),
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
                            text: 'Jesica Robles',
                          ),
                          InfoField(
                            label: l10n.registerPagePersonalPhoneLabel,
                            text: '964747675',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 90),
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
                            image: const DecorationImage(
                              image: AssetImage(Assets.testImg),
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
                            text: 'Editorial chevere',
                          ),
                          InfoField(
                            label: l10n.registerPageLibraryWebLabel,
                            text: 'www.editorialcvr.org',
                          ),
                          InfoField(
                            label: l10n.registerPageLibraryDescriptionLabel,
                            text: 'Soy una editorial chevere',
                          ),
                          InfoField(
                            label: l10n.libraryInfoTimetable,
                            text: '10 AM - 8 PM',
                          ),
                          InfoField(
                            label: l10n.registerPageLibraryRolLabel,
                            text: 'Editorial',
                          ),
                          InfoField(
                            label: l10n.adminPagePhysicalAddress,
                            text: 'Av. La Marina',
                          ),
                          InfoField(
                            label: l10n.adminPageMapLocation,
                            text: 'Urb. Tasahuayo, Direcciones largas 2 lineas',
                            maxLines: 2,
                            suffixIcon: Icon(
                              Icons.check,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.38,
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.5,
                              minHeight: 200,
                            ),
                            child: FlutterMap(
                              options: MapOptions(
                                center: LatLng(51.5, -0.09),
                                zoom: 10,
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
                                      point: LatLng(51.5, -0.09),
                                      builder: (ctx) => const Image(
                                        image:
                                            AssetImage(Assets.locationPinIcon),
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
                            children: [
                              CategoryChip(
                                label: 'Vendo libros',
                                isSelected: false,
                                onTap: () {},
                              ),
                              CategoryChip(
                                label: 'Recomiendo libros',
                                isSelected: false,
                                onTap: () {},
                              ),
                            ],
                          ),
                          InfoField(
                            label: l10n.adminPagePersonalLabels,
                            text: 'Etiqetas',
                            maxLines: 3,
                          ),
                          const SizedBox(height: 70),
                          Visibility(
                            visible: index == 0,
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    height: 56,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text(l10n.accept),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      final confirmLabel = l10n
                                          .adminPageDialogRejectRequestConfirm;
                                      pDialog(
                                        body: l10n
                                            .adminPageDialogRejectRequestBody,
                                        confirmLabel: confirmLabel,
                                        context: context,
                                        onConfirm: () {},
                                        title: l10n
                                            .adminPageDialogRejectRequestTitle,
                                      );
                                    },
                                    child: Text(
                                      l10n.reject,
                                      style:
                                          const TextStyle(color: PColors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: index == 1,
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  pDialog(
                                    body: l10n.adminPageDialogRemoveLibraryBody,
                                    confirmLabel: l10n
                                        .adminPageDialogRemoveLibraryConfirm,
                                    context: context,
                                    onConfirm: () {},
                                    title:
                                        l10n.adminPageDialogRemoveLibraryTitle,
                                  );
                                },
                                child: Text(
                                  l10n.adminPageRemoveLibrary,
                                  style: const TextStyle(color: PColors.red),
                                ),
                              ),
                            ),
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
        ),
      ),
    );
  }
}
