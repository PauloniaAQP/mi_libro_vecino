import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> uiPickImage({
  ImageSource? imageSource,
}) async {
  File? image;
  if (imageSource != null) {
    final _imagePicker = ImagePicker();
    final pickedfile = await _imagePicker.pickImage(source: imageSource);
    if (pickedfile != null) {
      image = File(pickedfile.path);
    }
  } else {
    final _imagePicker = ImagePicker();
    final pickedfile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      image = File(pickedfile.path);
    }
  }
  return image;
}
