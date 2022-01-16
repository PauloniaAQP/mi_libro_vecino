import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/authentication/components/category_chip.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LibraryCategoriesPage extends StatelessWidget {
  const LibraryCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.registerPageLibraryInformationTitle +
                  state.libraryRolController.text,
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
                    Text(
                      context.l10n.registerPageServicesTitle,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      context.l10n.registerPageChosseServices,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: PColors.gray4,
                          ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: List.generate(
                            state.services.length,
                            (index) {
                              // print(state.services.values.elementAt(index));
                              // TODO(oscarnar): Fix error to rebuild this 
                              // widget when is tapped
                              return CategoryChip(
                                onTap: () {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .updateServices(
                                    key: state.services.keys.elementAt(index),
                                  );
                                },
                                isSelected:
                                    state.services.values.elementAt(index),
                                label: state.services.keys.elementAt(index),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    ReactiveForm(
                      formGroup: state.libraryInfoForm,
                      child: PTextField(
                        formControlName: RegisterState.libraryLabelsController,
                        hintText:
                            context.l10n.registerPageCategoriesLabelsHintText,
                        label: context.l10n.registerPageCategoriesLabels,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
