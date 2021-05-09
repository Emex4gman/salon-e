// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier {
  factory AuthState() => _instance;
  static final AuthState _instance = AuthState._internal();
  AuthState._internal();
  AuthUser? _user;
  AuthUser? get user => _user;

  Future<void> setUser() async {
    try {
      _user = await Amplify.Auth.getCurrentUser();
    } catch (e) {
      _user = null;
      print(e);
    }
    notifyListeners();
  }
}
