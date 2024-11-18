import 'package:flutter/widgets.dart';
import '../model/user_model.dart';
import '../resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser =>
      _user ??
      const UserModel(
          username: '',
          uid: '',
          photoUrl: '',
          email: '',
          bio: '',
          followers: [],
          following: []);

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    print(user.uid);
    _user = user;
    notifyListeners();
  }
}
