import 'dart:async';

import '../models/user_model.dart';

class UserService {
  static final List<UserModel> _users = [];

  Future<List<UserModel>> getUsers() async {
    return _users;
  }

  Future<void> addUser(UserModel user) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    _users.add(user);
  }

  Future<void> updateUser(
    UserModel updatedUser,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    final index = _users.indexWhere(
      (user) => user.id == updatedUser.id,
    );

    if (index != -1) {
      _users[index] = updatedUser;
    }
  }

  Future<void> deleteUser(String id) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    _users.removeWhere(
      (user) => user.id == id,
    );
  }
}
