import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mi_libro_vecino/app/bloc/app_user_bloc.dart';
import 'package:mi_libro_vecino/authentication/components/location_map.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:mi_libro_vecino_api/services/geo_service.dart'
    if (dart.library.io) 'package:mi_libro_vecino_api/services/test_geo_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LibraryMapPage extends StatefulWidget {
  const LibraryMapPage({Key? key}) : super(key: key);

  @override
  State<LibraryMapPage> createState() => _LibraryMapPageState();
}

class _LibraryMapPageState extends State<LibraryMapPage> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    GeoService.getPermission().then((permission) {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(context.l10n.locationDisableDialogTitle),
            content: Text(
              context.l10n.locationDisableDialogContent,
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(context.l10n.accept),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<RegisterCubit>().backPage();
                },
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final libraryRol = getStringRolByType(
          LibraryType.values[int.parse(
            state.libraryRolController.text == ''
                ? '0'
                : state.libraryRolController.text,
          )],
          l10n,
        );
        return ReactiveForm(
          formGroup: state.libraryInfoForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.registerPageLibraryInformationTitle + libraryRol,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 20),
                      Text(
                        l10n.registerPageLibraryMapLabel,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: PColors.gray1,
                            ),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<String?>(
                        future: GeoService.getAddress(state.location),
                        builder: (context, snapshot) {
                          state.libraryInfoForm
                                  .control(RegisterState.addressController)
                                  .value =
                              snapshot.connectionState == ConnectionState.done
                                  ? snapshot.data ?? ''
                                  : '';
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  snapshot.connectionState ==
                                          ConnectionState.done
                                      ? snapshot.data ??
                                          l10n.messageValidationToUnknownAddress
                                      : l10n.messageValidationToLoadingAddress,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Visibility(
                                  visible: snapshot.connectionState !=
                                      ConnectionState.done,
                                  child: const CupertinoActivityIndicator(),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.38,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.5,
                          minHeight: 200,
                        ),
                        child: BlocBuilder<AppUserBloc, AppUserState>(
                          builder: (context, appUserState) {
                            if (appUserState.currentLocation == null) {
                              context.read<AppUserBloc>().checkLocation();
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return LocationMap(
                              center: appUserState.currentLocation!,
                              point: appUserState.currentLocation!,
                              onPositionChanged: (mapPos, wasTaped) {
                                if (mapPos.center == null) return;
                                final center = Coordinates(
                                  mapPos.center!.latitude,
                                  mapPos.center!.longitude,
                                );

                                if (_debounce?.isActive ?? false) {
                                  _debounce?.cancel();
                                }
                                _debounce = Timer(
                                  const Duration(milliseconds: 700),
                                  () => context
                                      .read<RegisterCubit>()
                                      .setMapLocation(center),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
