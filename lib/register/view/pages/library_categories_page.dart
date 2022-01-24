import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/register/components/category_chip.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LibraryCategoriesPage extends StatelessWidget {
  const LibraryCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.registerPageLibraryInformationTitle,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                context.l10n.registerPageCategoriesTitle,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                context.l10n.registerPageChosseCategories,
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
                      5,
                      (index) {
                        const label = 'Chip label';
                        const value = true;
                        return CategoryChip(
                          onTap: () {},
                          isSelected: value,
                          label: label,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Text(
                context.l10n.registerPageCategoriesLabels,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: PColors.gray1,
                    ),
              ),
              ReactiveForm(
                formGroup: state.libraryInfoForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ReactiveTextField<String>(
                      formControlName: RegisterState.libraryLabelsController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText:
                            context.l10n.registerPageCategoriesLabelsHintText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
