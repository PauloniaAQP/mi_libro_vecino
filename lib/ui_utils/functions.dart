import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino_api/models/ubigeo_model.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/library_enums.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/ubigeo_enums.dart';
import 'package:mi_libro_vecino_api/utils/constants/enums/user_enums.dart';

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

/// Gets the string of library type from the enum
/// [l10n] could be get from context.l10n
// TODO(oscarnar): Internationalize
String getStringLoginStatus(LoginState status, AppLocalizations l10n) {
  switch (status) {
    case LoginState.errorAccountExistsWithDifferentCredential:
      return 'Cuenta con diferentes credenciales';
    case LoginState.errorNetworkRequestFailed:
      return 'Error de conexión';
    case LoginState.errorUserNotFound:
      return 'Email no encontrado';
    case LoginState.errorWrongPassword:
      return 'Contraseña incorrecta';
    case LoginState.errorTooManyRequests:
      return 'Exceso de peticiones';
    case LoginState.unknownError:
      return 'Error desconocido';
    case LoginState.canceledByTheUser:
      return 'Cancelado por el usuario';
    case LoginState.errorEmailAlreadyInUse:
      return 'Email ya en uso';
    case LoginState.errorWeekPassword:
      return 'Contraseña muy corta';
    case LoginState.errorInvalidEmail:
      return 'Email inválido';
    case LoginState.success:
      return 'Éxito';
    case LoginState.errorBadLogin:
      return 'Error de inicio de sesión';
    case LoginState.errorInServer:
      return 'Error en el servidor';
  }
}

/// Gets a string of the ubigeo name
/// If the ubigeo is a district, it will return the name of the province
/// and the name of the department
///
/// district, province, department
String getNameFromUbigeo(UbigeoModel ubigeo) {
  switch (ubigeo.type) {
    case UbigeoType.department:
      return ubigeo.departmentName;
    case UbigeoType.province:
      return '${ubigeo.provinceName}, ${ubigeo.departmentName}';
    case UbigeoType.district:
      return '''${ubigeo.districtName}, ${ubigeo.provinceName}, ${ubigeo.departmentName}''';
  }
}

/// Returns the ubigeo code according to the type
String getUbigeoCodeFromUbigeo(UbigeoModel ubigeo) {
  switch (ubigeo.type) {
    case UbigeoType.department:
      return ubigeo.departmentId;
    case UbigeoType.province:
      return '${ubigeo.provinceId}';
    case UbigeoType.district:
      return '${ubigeo.districtId}';
  }
}
