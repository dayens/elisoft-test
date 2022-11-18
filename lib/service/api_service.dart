import 'dart:convert';

import 'package:flutter_test_elisoft/model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://demo.treblle.com/api/v1/';

  Future userLogin(String username, String password) async {
    final response = await http.post(Uri.parse(baseUrl + 'auth/login'),
        body: {'email': username, 'password': password});

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      return Exception('Gagal memuat data');
    }
  }
}
