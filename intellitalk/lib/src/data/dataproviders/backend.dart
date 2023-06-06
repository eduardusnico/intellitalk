import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intellitalk/constants.dart';
import 'package:intellitalk/src/data/models/listUser_m.dart';
import 'package:intellitalk/src/data/models/user_m.dart';

class Backend {
  Future<List<User>?> fetchAllUser() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/users'));
      final data = json.decode(response.body);
      if (data['status'] == true) {
        final userResponse = ListUser.fromJson(response.body);
        return userResponse.users;
      }
    } catch (e) {
      log('$e');
    }
    return null;
  }

  Future<User?> fetchDataUser(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/users/$id'));
      final data = json.decode(response.body);
      if (data['status'] == true) {
        final userResponse = UserResponse.fromJson(response.body);
        return userResponse.user;
      }
    } catch (e) {
      log('$e');
    }
    return null;
  }
}
