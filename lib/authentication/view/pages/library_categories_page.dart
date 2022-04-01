import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/category_chip.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/p_text_field.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LibraryCategoriesPage extends StatelessWidget {
  const LibraryCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final libraryRol = getStringRolByType(
      LibraryType.values[int.parse(
        context.read<RegisterCubit>().state.libraryRolController.text == ''
            ? '0'
            : context.read<RegisterCubit>().state.libraryRolController.text,
      )],
      l10n,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.registerPageLibraryInformationTitle + libraryRol,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
            return SingleChildScrollView(
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
            );
          }),
        ),
      ],
    );
  }
}
