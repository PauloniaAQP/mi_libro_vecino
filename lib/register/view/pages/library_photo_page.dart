import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/register/cubit/register_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class LibraryPhotoPage extends StatelessWidget {
  const LibraryPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.registerPageLibraryInformationTitle,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 35),
        Text(
          l10n.registerPageLibraryPhotoLabel,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: PColors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffF9F9F9),
                    image: (state.libraryPhoto != null)
                        ? DecorationImage(image: FileImage(state.libraryPhoto!))
                        : null,
                  ),
                  child: Builder(
                    builder: (_) {
                      if (state is RegisterPhotoLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<RegisterCubit>(context)
                              .onTapUploadLibraryPhoto();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              state.libraryPhoto != null
                                  ? Assets.imageWhiteIcon
                                  : Assets.imageIcon,
                              fit: BoxFit.cover,
                              height: 65,
                              width: 65,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              state.libraryPhoto != null
                                  ? l10n
                                      .registerPageLibraryChangePhotoButtonLabel
                                  : l10n.registerPageLibraryPhotoButtonLabel,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: PColors.gray2,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
