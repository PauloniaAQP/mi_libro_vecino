import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class PickImage extends StatelessWidget {
  const PickImage({
    Key? key,
    this.personPhoto,
    this.isLoading = false,
    required this.onTap,
    required this.pickLabel,
    required this.modifyLabel,
    required this.unselectedPhotoIconPath,
    required this.selectedPhotoIconPath,
  }) : super(key: key);

  final File? personPhoto;
  final bool isLoading;
  final VoidCallback onTap;
  final String pickLabel;
  final String modifyLabel;
  final String unselectedPhotoIconPath;
  final String selectedPhotoIconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.width * 0.3,
      width: MediaQuery.of(context).size.width * 0.3,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.width * 0.4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: PColors.black,
        ),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xffF9F9F9),
        image: (personPhoto != null)
            ? DecorationImage(
                image: FileImage(personPhoto!),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Builder(
        builder: (context) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  personPhoto != null
                      ? selectedPhotoIconPath
                      : unselectedPhotoIconPath,
                  height: 65,
                  width: 65,
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: Text(
                    personPhoto != null ? modifyLabel : pickLabel,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: PColors.gray2,
                        ),
                    overflow: TextOverflow.ellipsis,
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
