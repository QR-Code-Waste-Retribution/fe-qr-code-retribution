import 'package:get/get.dart';
import 'package:qr_code_app/models/user.dart';
import 'package:qr_code_app/services/repositories/user_repositories.dart';

class UsersProvider extends GetxController {
  final UserRepositories userRepositories = UserRepositories();

  final RxList<User> userList = <User>[].obs;

  
}
