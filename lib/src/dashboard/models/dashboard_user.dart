part of './models.dart';

class FlutterDashboardUser {
  final String? username;
  final String email;
  final String password;
  final String? profilePic;
  final String role;
  final bool canLoginIntoDashboard;

  const FlutterDashboardUser({
    this.username = 'Admin',
    required this.email,
    required this.password,
    this.profilePic,
    this.role = 'Admin',
    this.canLoginIntoDashboard = true,
  });
}
