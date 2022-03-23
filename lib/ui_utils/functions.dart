import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';

Future<XFile?> uiPickImage({ImageSource? imageSource}) async {
  XFile? image;
  if (imageSource != null) {
    final _imagePicker = ImagePicker();
    final pickedfile = await _imagePicker.pickImage(source: imageSource);
    if (pickedfile != null) {
      image = pickedfile;
    }
  } else {
    final _imagePicker = ImagePicker();
    final pickedfile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      image = pickedfile;
    }
  }
  return image;
}

TimeOfDay fromStringToTimeOfDay(String time) {
  final timeSplit = time.split(':');
  return TimeOfDay(
    hour: int.parse(timeSplit[0]),
    minute: int.parse(timeSplit[1]),
  );
}

/// Gets the string of library type from the enum
/// [l10n] could be get from context.l10n
String getStringRolByType(LibraryType type, AppLocalizations l10n) {
  switch (type) {
    case LibraryType.bookshop:
      return l10n.registerPageRolBookshop;
    case LibraryType.mediator:
      return l10n.registerPageRolMediator;
    case LibraryType.editorial:
      return l10n.registerPageRolEditorial;
    case LibraryType.library:
      return l10n.registerPageRolLibrary;
  }
}
