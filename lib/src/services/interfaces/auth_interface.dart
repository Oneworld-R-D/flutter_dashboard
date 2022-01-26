part of '../flutter_dashboard_services.dart';

abstract class _FlutterDashboardAuthInsterface {
  final GetStorage getStorage = GetStorage();

  String? readAuthToken() {
    String? _token = getStorage.read('token');
    return _token;
  }

  bool saveAuthToken(String _token) {
    getStorage.write('token', _token);
    return true;
  }

  bool removeAuthToken() {
    getStorage.remove('token');
    return true;
  }

  Future<void> logout();

  Future<bool?> login(Map<String, dynamic> credential) async {
    return false;
  }

  Future<bool> register(Map<String, dynamic> registrationPayload) async {
    return false;
  }
}
