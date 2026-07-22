enum UserRole { user, admin }

class AppUser {
  final String name;
  final String email;
  final UserRole role;

  const AppUser({
    required this.name,
    required this.email,
    required this.role,
  });

  bool get isAdmin => role == UserRole.admin;
  bool get isUser => role == UserRole.user;

  String get roleLabel => isAdmin ? 'Admin' : 'User';
}

class DemoAccount {
  final String email;
  final String password;
  final AppUser user;

  const DemoAccount({
    required this.email,
    required this.password,
    required this.user,
  });
}

class AuthAccounts {
  static const List<DemoAccount> defaults = [
    DemoAccount(
      email: 'user@smartmart.com',
      password: 'user123',
      user: AppUser(
        name: 'SmartMart User',
        email: 'user@smartmart.com',
        role: UserRole.user,
      ),
    ),
    DemoAccount(
      email: 'admin@smartmart.com',
      password: 'admin123',
      user: AppUser(
        name: 'SmartMart Admin',
        email: 'admin@smartmart.com',
        role: UserRole.admin,
      ),
    ),
  ];
}
