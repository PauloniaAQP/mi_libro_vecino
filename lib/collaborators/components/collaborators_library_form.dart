import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/authentication/components/location_map.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/category_chip.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/future_with_loading.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_dropdown_button.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:mi_libro_vecino_api/services/geo_service.dart'
    if (dart.library.io) 'package:mi_libro_vecino_api/services/test_geo_service.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CollaboratorsLibraryForm extends StatefulWidget {
  const CollaboratorsLibraryForm({
    Key? key,
  }) : super(key: key);

  @override
  State<CollaboratorsLibraryForm> createState() =>
      _CollaboratorsLibraryFormState();
}

class _CollaboratorsLibraryFormState extends State<CollaboratorsLibraryForm> {
  Timer? _debounce;
  late bool _isTouchedLib;

  @override
  void initState() {
    super.initState();
    _isTouchedLib = context.read<CollaboratorCubit>().libraryInfoWasTouched;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<CollaboratorCubit, CollaboratorState>(
      builder: (context, state) {
        state.libraryInfoForm.valueChanges.listen((event) {
          context.read<CollaboratorCubit>().maskAsTouchedLibraryInfo();
          if (_isTouchedLib) {
            return;
          } else {
            setState(() {
              _isTouchedLib =
                  context.read<CollaboratorCubit>().libraryInfoWasTouched;
            });
          }
        });
        return ReactiveForm(
          key: const Key('collaborators_library_form'),
          formGroup: state.libraryInfoForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PTextField(
                label: l10n.registerPageLibraryNameLabel,
                hintText: l10n.registerPageLibraryNameHintText,
                formControlName: CollaboratorState.libraryNameController,
                validationMessages: {
                  ValidationMessage.required:
                      l10n.registerPageLibraryNameErrorTextRequired,
                },
              ),
              PTextField(
                label: l10n.registerPageLibraryWebLabel,
                hintText: l10n.registerPageLibraryWebHintText,
                formControlName: CollaboratorState.websiteController,
                keyboardType: TextInputType.url,
              ),
              PTextField(
                label: l10n.registerPageLibraryDescriptionLabel,
                hintText: l10n.registerPageLibraryDescriptionHintText,
                formControlName: CollaboratorState.descriptionController,
                keyboardType: TextInputType.number,
                validationMessages: {
                  ValidationMessage.required:
                      l10n.registerPageLibraryDescriptionErrorText,
                },
              ),
              ScreenTypeLayout(
                mobile: Column(
                  children: [
                    PTextField(
                      label: l10n.registerPageLibraryOpeningTimeLabel,
                      hintText: l10n.registerPageLibraryTimeHintText,
                      formControlName: CollaboratorState.openTimeController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: Container(
                              height: 24,
                              width: 1,
                              color: PColors.gray2,
                            ),
                          ),
                          PDropdownButton(
                            valuesList: const ['AM', 'PM'],
                            controller: state.openingController,
                          ),
                        ],
                      ),
                      validationMessages: {
                        ValidationMessage.required:
                            l10n.registerPageLibraryTimeErrorTextRequired,
                      },
                    ),
                    PTextField(
                      label: l10n.registerPageLibraryClosingTimeLabel,
                      hintText: l10n.registerPageLibraryTimeHintText,
                      formControlName: CollaboratorState.closeTimeController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: Container(
                              height: 24,
                              width: 1,
                              color: PColors.gray2,
                            ),
                          ),
                          PDropdownButton(
                            valuesList: const ['AM', 'PM'],
                            controller: state.closingController,
                          ),
                        ],
                      ),
                      validationMessages: {
                        ValidationMessage.required:
                            l10n.registerPageLibraryTimeErrorTextRequired,
                      },
                    ),
                  ],
                ),
                desktop: Row(
                  children: [
                    Expanded(
                      child: PTextField(
                        label: l10n.registerPageLibraryOpeningTimeLabel,
                        hintText: l10n.registerPageLibraryTimeHintText,
                        formControlName: CollaboratorState.openTimeController,
                        keyboardType: TextInputType.number,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Container(
                                height: 24,
                                width: 1,
                                color: PColors.gray2,
                              ),
                            ),
                            PDropdownButton(
                              valuesList: const ['AM', 'PM'],
                              controller: state.openingController,
                            ),
                          ],
                        ),
                        validationMessages: {
                          ValidationMessage.required:
                              l10n.registerPageLibraryTimeErrorTextRequired,
                        },
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: PTextField(
                        label: l10n.registerPageLibraryClosingTimeLabel,
                        hintText: l10n.registerPageLibraryTimeHintText,
                        formControlName: CollaboratorState.closeTimeController,
                        keyboardType: TextInputType.number,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Container(
                                height: 24,
                                width: 1,
                                color: PColors.gray2,
                              ),
                            ),
                            PDropdownButton(
                              valuesList: const ['AM', 'PM'],
                              controller: state.closingController,
                            ),
                          ],
                        ),
                        validationMessages: {
                          ValidationMessage.required:
                              l10n.registerPageLibraryTimeErrorTextRequired,
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  context.l10n.registerPageLibraryRolLabel,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: PColors.gray1,
                      ),
                ),
              ),
              PDropdownButton(
                valuesList: List.generate(
                  LibraryType.values.length,
                  (index) =>
                      getStringRolByType(LibraryType.values[index], l10n),
                ),
                controller: state.libraryRolController,
                isExpanded: true,
              ),
              PTextField(
                label: l10n.registerPageLibraryAddressLabel,
                hintText: l10n.registerPageLibraryAddressHintText,
                formControlName: CollaboratorState.addressController,
                validationMessages: {
                  ValidationMessage.required:
                      l10n.registerPageLibraryAddressErrorTextRequired,
                },
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
              Map(l10n: l10n),
              const SizedBox(height: 8),
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                  minHeight: 200,
                ),
                child: LocationMap(
                  center: state.location,
                  point: state.location,
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
                          .read<CollaboratorCubit>()
                          .setMapLocation(center),
                    );
                  },
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
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: PColors.black,
                      ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                  state.services.keys.length,
                  (index) {
                    return CategoryChip(
                      label: state.services.keys.elementAt(index),
                      isSelected: state.services.values.elementAt(index),
                      onTap: () {
                        BlocProvider.of<CollaboratorCubit>(context)
                            .updateServices(
                          key: state.services.keys.elementAt(index),
                        );
                      },
                    );
                  },
                ),
              ),
              PTextField(
                formControlName: CollaboratorState.libraryLabelsController,
                hintText: l10n.registerPageCategoriesLabelsHintText,
                label: l10n.registerPageCategoriesLabels,
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: SizedBox(
                    height: 56,
                    width: 400,
                    child: ElevatedButton(
                      onPressed: (!_isTouchedLib)
                          ? null
                          : () {
                              futureWithLoading(
                                context
                                    .read<CollaboratorCubit>()
                                    .onTapSaveLibrary(),
                                context,
                              ).then(
                                (value) =>
                                    setState(() => _isTouchedLib = false),
                              );
                            },
                      child: Text(
                        l10n.collaboratorsPageSaveButton,
                        textAlign: TextAlign.center,
                      ),
                    ),
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

class Map extends StatelessWidget {
  const Map({
    Key? key,
    required this.l10n,
  }) : super(key: key);

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollaboratorCubit, CollaboratorState>(
      builder: (context, state) {
        return FutureBuilder<String?>(
          future: GeoService.getAddress(state.location),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (state.libraryInfoForm
                      .value[CollaboratorState.addressController] !=
                  snapshot.data) {
                state.libraryInfoForm
                    .control(CollaboratorState.addressController)
                    .value = snapshot.data ?? '';
              }
            }

            return Row(
              children: [
                Expanded(
                  child: Text(
                    snapshot.connectionState == ConnectionState.done
                        ? snapshot.data ??
                            l10n.messageValidationToUnknownAddress
                        : l10n.messageValidationToLoadingAddress,
                  ),
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: (snapshot.connectionState == ConnectionState.done)
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        )
                      : const CupertinoActivityIndicator(),
                )
              ],
            );
          },
        );
      },
    );
  }
}
