import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {

  final storage = FlutterSecureStorage();

  final String baseUrl = "https://task.itprojects.web.id";

  Future<bool> login(String username, String password) async {

    final url = Uri.parse('$baseUrl/api/auth/login');

    final response = await http.post(
      url,

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },

      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      String token = data['data']['token'];

      // simpan token
      await storage.write(
        key: 'token',
        value: token,
      );

      // ignore: avoid_print
      print("LOGIN BERHASIL");
      // ignore: avoid_print
      print(token);

      return true;

    } else {

      // ignore: avoid_print
      print("LOGIN GAGAL");
      // ignore: avoid_print
      print(response.body);

      return false;
    }
  }
}