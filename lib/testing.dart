import 'package:mi_libro_vecino_api/repositories/user_repository.dart';

Future<void> testing() async {
  UserRepository userRepository = UserRepository();
  var userModel = await userRepository.createUser(
    userId: '123',
    name: 'Oscar',
    email: 'oscarmas@oscar.com',
    phone: '1324596798',
  );
  print(userModel);
  return;
}
