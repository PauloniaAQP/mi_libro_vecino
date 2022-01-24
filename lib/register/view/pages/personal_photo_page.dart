import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/register/components/pick_image.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class PersonalPhoto extends StatelessWidget {
  const PersonalPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.registerPagePersonalInformationTitle,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 35),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.registerPagePersonalPhotoLabel,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return Center(
                      child: PickImage(
                        isLoading: state is RegisterPhotoLoading,
                        pickLabel: l10n.registerPagePersonalPhotoButtonLabel,
                        modifyLabel:
                            l10n.registerPageLibraryChangePhotoButtonLabel,
                        onTap: () {
                          BlocProvider.of<RegisterCubit>(context)
                              .onTapUploadPersonalPhoto();
                        },
                        selectedPhotoIconPath: Assets.profileWhiteIcon,
                        unselectedPhotoIconPath: Assets.profileIcon,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
