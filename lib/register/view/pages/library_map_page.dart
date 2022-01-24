import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LibraryMapPage extends StatelessWidget {
  const LibraryMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.registerPageLibraryInformationTitle,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 30),
            ReactiveForm(
              formGroup: state.libraryInfoForm,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PTextField(
                    label: l10n.registerPageLibraryAddressLabel,
                    hintText: l10n.registerPageLibraryAddressHintText,
                    formControlName: RegisterState.addressController,
                    validationMessages: {
                      ValidationMessage.required:
                          l10n.registerPageLibraryAddressErrorTextRequired,
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              l10n.registerPageLibraryMapLabel,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: PColors.gray1,
                  ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
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
                        builder: (ctx) => const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
