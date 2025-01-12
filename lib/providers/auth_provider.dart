// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null && _user!.token.isNotEmpty;

  Future<void> register(String username, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      User newUser = await ApiService.register(username, email, password);
      _user = newUser;
      // Guardar token en storage si quieres
    } catch (e) {
      print("Error en register: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      User loggedUser = await ApiService.login(email, password);
      _user = loggedUser;
      // Guardar token en storage si quieres
    } catch (e) {
      print("Error en login: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
