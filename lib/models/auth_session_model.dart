import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthSessionModel extends ChangeNotifier {
  UserCredential? user;

  User? getUser() {
    if (user != null) return user!.user;
    return null;
  }

  void setUser(UserCredential user) {
    this.user = user;
    notifyListeners();
  }
}
