import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_dropdown_button.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CollaboratorsLibraryForm extends StatelessWidget {
  const CollaboratorsLibraryForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final rolesList = <String>[
      l10n.registerPageRolMediator,
      l10n.registerPageRolLibrary,
      l10n.registerPageRolEditorial,
      l10n.registerPageRolBookshop,
    ];
    return SingleChildScrollView(
      child: BlocBuilder<CollaboratorCubit, CollaboratorState>(
        builder: (context, state) {
          return ReactiveForm(
            formGroup: state.libraryInfoForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PTextField(
                  label: context.l10n.registerPageLibraryNameLabel,
                  hintText:
                      context.l10n.registerPageLibraryNameHintText,
                  formControlName:
                      CollaboratorState.libraryNameController,
                  validationMessages: {
                    ValidationMessage.required: context.l10n
                        .registerPageLibraryNameErrorTextRequired,
                  },
                ),
                PTextField(
                  label: context.l10n.registerPageLibraryWebLabel,
                  hintText:
                      context.l10n.registerPageLibraryWebHintText,
                  formControlName:
                      CollaboratorState.websiteController,
                  keyboardType: TextInputType.url,
                ),
                PTextField(
                  label: context
                      .l10n.registerPageLibraryDescriptionLabel,
                  hintText: context
                      .l10n.registerPageLibraryDescriptionHintText,
                  formControlName:
                      CollaboratorState.descriptionController,
                  keyboardType: TextInputType.number,
                  validationMessages: {
                    ValidationMessage.required: context
                        .l10n.registerPageLibraryDescriptionErrorText,
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: PTextField(
                        label: context
                            .l10n.registerPageLibraryOpeningTimeLabel,
                        hintText: context
                            .l10n.registerPageLibraryTimeHintText,
                        formControlName:
                            CollaboratorState.openTimeController,
                        keyboardType: TextInputType.number,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
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
                          ValidationMessage.required: context.l10n
                              .registerPageLibraryTimeErrorTextRequired,
                        },
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: PTextField(
                        label: context
                            .l10n.registerPageLibraryClosingTimeLabel,
                        hintText: context
                            .l10n.registerPageLibraryTimeHintText,
                        formControlName:
                            CollaboratorState.closeTimeController,
                        keyboardType: TextInputType.number,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
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
                          ValidationMessage.required: context.l10n
                              .registerPageLibraryTimeErrorTextRequired,
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    context.l10n.registerPageLibraryRolLabel,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: PColors.gray1,
                        ),
                  ),
                ),
                PDropdownButton(
                  valuesList: rolesList,
                  controller: state.libraryRolController,
                  isExpanded: true,
                ),
                PTextField(
                  label: l10n.registerPageLibraryAddressLabel,
                  hintText: l10n.registerPageLibraryAddressHintText,
                  formControlName:
                      CollaboratorState.addressController,
                  validationMessages: {
                    ValidationMessage.required: l10n
                        .registerPageLibraryAddressErrorTextRequired,
                  },
                ),
                const SizedBox(height: 5),
                Text(
                  l10n.registerPageLibraryMapLabel,
                  style:
                      Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: PColors.gray1,
                          ),
                ),
                ReactiveTextField<String>(
                  formControlName:
                      CollaboratorState.addressController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: (state.libraryInfoForm.value[
                                CollaboratorState
                                    .mapAddressController] !=
                            '')
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.check,
                            color:
                                Theme.of(context).colorScheme.primary,
                          ),
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                  ),
                  readOnly: true,
                  maxLines: 2,
                  minLines: 1,
                ),
                const SizedBox(height: 8),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: SizedBox(
                      height: 56,
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () {},
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
      ),
    );
  }
}
