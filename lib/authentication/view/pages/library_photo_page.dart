import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/authentication/components/pick_image.dart';
import 'package:mi_libro_vecino/authentication/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class LibraryPhotoPage extends StatelessWidget {
  const LibraryPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.registerPageLibraryInformationTitle +
                  state.libraryRolController.text,
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
                      l10n.registerPageLibraryPhotoLabel,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: PickImage(
                        isLoading: state is RegisterPhotoLoading,
                        pickLabel: l10n.registerPageLibraryPhotoButtonLabel,
                        modifyLabel:
                            l10n.registerPageLibraryChangePhotoButtonLabel,
                        onTap: () {
                          BlocProvider.of<RegisterCubit>(context)
                              .onTapUploadLibraryPhoto();
                        },
                        selectedPhotoIconPath: Assets.imageWhiteIcon,
                        unselectedPhotoIconPath: Assets.imageIcon,
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
