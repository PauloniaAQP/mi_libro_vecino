import 'dart:typed_data';

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

  BoxDecoration get _boxDecoration {
    if (image == null) {
      return BoxDecoration(
        border: Border.all(
          color: PColors.black,
        ),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xffF9F9F9),
      );
    } else {
      return BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(image!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: (image != null)
          ? Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    image: MemoryImage(image!),
                    colorBlendMode: BlendMode.multiply,
                    color: PColors.gray2,
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
          : Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.width * 0.4,
              ),
              decoration: _boxDecoration,
              padding: const EdgeInsets.symmetric(vertical: 15),
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
                  color: image == null ? PColors.gray2 : PColors.white,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
