import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intellitalk/constants.dart';
import 'package:intellitalk/src/data/models/messages_m.dart';
import 'package:intellitalk/src/data/models/resp_list_message_m.dart';
import 'package:intellitalk/src/data/models/resp_list_user_m.dart';
import 'package:intellitalk/src/data/models/user_m.dart';
import 'package:intellitalk/src/data/models/resp_user_m.dart';

class Backend {
  Future<List<User>?> fetchUserDoneInterview() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/v1/users/conversations'));
      final data = ResponseListUser.fromJson(response.body);
      if (data.status == true) {
        return data.users.reversed.toList();
      }
    } catch (e) {
      log('$e');
    }
    return null;
  }

  Future<Messages?> fetchDetailConversationById(String id) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/v1/conversations/$id'));
      final data = ResponseListMessage.fromJson(response.body);
      if (data.status == true) {
        return data.listMessage;
      }
      return null;
    } catch (e) {
      log('$e');
    }
    return null;
  }

  Future<bool> postConversation(List listConvo, String name, String id) async {
    try {
      Map<String, dynamic> body = {};
      List<dynamic> temp = [];

      for (int i = 1; i < listConvo.length; i++) {
        if (i % 2 != 0) {
          temp.add({'sender': 'Arkademi Bot', "message": listConvo[i]});
        } else {
          temp.add({'sender': name, 'message': listConvo[i]});
        }
      }
      body = {"user_id": id, "messages": temp};
      final response = await http.post(
          Uri.parse(
            '$baseUrl/api/v1/conversations',
          ),
          body: json.encode(body));
      final data = json.decode(response.body);
      if (data['status'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<bool> addNewCandidate(String name, String email, String division,
      String position, String skill, int quantity) async {
    try {
      final Map<String, dynamic> body = {
        "name": name,
        "email": email,
        "division": division,
        "position": position,
        "skill": skill,
        "quantity": quantity,
      };
      final response = await http.post(Uri.parse('$baseUrl/api/v1/users'),
          body: json.encode(body));
      final data = json.decode(response.body);
      print(data);
      if (data['status'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<List<User>?> fetchAllUser() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/users'));
      final data = ResponseListUser.fromJson(response.body);
      if (data.status == true) {
        return data.users.reversed.toList();
      }
    } catch (e) {
      log('$e');
    }
    return null;
  }

  Future<User?> fetchDataUser(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/users/$id'));
      final data = ResponseUser.fromJson(response.body);
      if (data.status == true) {
        return data.user;
      }
    } catch (e) {
      log('$e');
    }
    return null;
  }
}
