import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imtihon3_clon/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHttpServices {
  final String _apiKey = "AIzaSyACUcRCGNgaGIZ9jZaoUa19DHG9VVGqVFg";

  Future<void> register(String email, String password) async {
    UserController userController = UserController();
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw (data['error']['message']);
      }
      userController.addUser(email, data['localId']);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("userId", data['localId']);
    } catch (e) {
      rethrow;
    }
  }

  Future login(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        
        throw (data['error']['message']);
      }

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("userId", data['localId']);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    if (token == null) {
      return false;
    }

    DateTime expiryDate =
        DateTime.parse(sharedPreferences.getString("expiryDate")!);

    return expiryDate.isAfter(DateTime.now());
  }

  Future<void> sendPasswordEmail(String email) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey");

    try {
      final response = await http.post(url,
          body: jsonEncode({'email': email, 'requestType': 'PASSWORD_RESET'}));
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data['error']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
