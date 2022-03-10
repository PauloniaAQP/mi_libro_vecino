import 'package:get/get.dart';
import 'package:mi_libro_vecino_api/models/user_model.dart';
import 'package:mi_libro_vecino_api/repositories/user_repository.dart';

class AppUserController extends GetxController {
  /// Logged user
  UserModel? get appUser => _appUser;

  /// Private stuff
  UserModel? _appUser;
  late UserRepository _repository;
  // HashMap<String, UserModel> _userMap = HashMap();
  // FirstLogin? _firstLogin = FirstLogin.FALSE;
}
