import 'package:flutter/foundation.dart';
import 'package:smartcart/models/app_user.dart';

class AuthController extends ChangeNotifier {
  AppUser? _currentUser;
  String? _error;

  AppUser? get currentUser => _currentUser;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  bool login(String email, String password) {
    final normalized = email.trim().toLowerCase();
    DemoAccount? match;
    for (final account in AuthAccounts.defaults) {
      if (account.email == normalized && account.password == password) {
        match = account;
        break;
      }
    }

    if (match == null) {
      _error = 'Invalid email or password';
      notifyListeners();
      return false;
    }

    _currentUser = match.user;
    _error = null;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    if (_error == null) return;
    _error = null;
    notifyListeners();
  }
}

final authController = AuthController();
