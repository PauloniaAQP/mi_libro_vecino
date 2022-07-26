import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class PickImage extends StatelessWidget {
  const PickImage({
    Key? key,
    required this.image,
    this.isLoading = false,
    required this.onTap,
    required this.pickLabel,
    required this.modifyLabel,
    required this.unselectedPhotoIconPath,
    required this.selectedPhotoIconPath,
  }) : super(key: key);

  final Uint8List? image;
  final bool isLoading;
  final VoidCallback onTap;
  final String pickLabel;
  final String modifyLabel;
  final String unselectedPhotoIconPath;
  final String selectedPhotoIconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * 0.5,
      width: MediaQuery.of(context).size.shortestSide * 0.5,
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: (image != null)
            ? Center(
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Image(
                      image: MemoryImage(image!),
                      colorBlendMode: BlendMode.multiply,
                      color: PColors.gray2,
                      fit: BoxFit.cover,
                    ),
                    Visibility(
                      visible: isLoading,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Visibility(
                      visible: !isLoading,
                      child: ImageIcon(
                        image: image,
                        selectedPhotoIconPath: selectedPhotoIconPath,
                        unselectedPhotoIconPath: unselectedPhotoIconPath,
                        modifyLabel: modifyLabel,
                        pickLabel: pickLabel,
                      ),
                    )
                  ],
                ),
              )
            : DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                dashPattern: const [8, 8],
                color: PColors.gray1,
                padding: EdgeInsets.zero,
                child: Center(
                  child: Builder(
                    builder: (context) {
                      if (isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ImageIcon(
                        image: image,
                        selectedPhotoIconPath: selectedPhotoIconPath,
                        unselectedPhotoIconPath: unselectedPhotoIconPath,
                        modifyLabel: modifyLabel,
                        pickLabel: pickLabel,
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}

class ImageIcon extends StatelessWidget {
  const ImageIcon({
    Key? key,
    required this.image,
    required this.selectedPhotoIconPath,
    required this.unselectedPhotoIconPath,
    required this.modifyLabel,
    required this.pickLabel,
  }) : super(key: key);

  final Uint8List? image;
  final String selectedPhotoIconPath;
  final String unselectedPhotoIconPath;
  final String modifyLabel;
  final String pickLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image != null ? selectedPhotoIconPath : unselectedPhotoIconPath,
          height: 65,
          width: 65,
        ),
        const SizedBox(height: 20),
        Flexible(
          child: Text(
            image != null ? modifyLabel : pickLabel,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: image == null ? PColors.gray1 : PColors.white,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
