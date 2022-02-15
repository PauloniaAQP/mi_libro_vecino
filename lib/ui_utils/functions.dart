// import 'dart:html';

import 'package:image_picker/image_picker.dart';

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
