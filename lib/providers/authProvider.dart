import 'dart:convert';

import 'package:cardio_ai/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool signedIn = false;
  String authState = "signIn";

  bool signingIn = false;
  bool signingUp = true;
  bool tokenChecked = false;
  String authErrors = "";

  String accessToken = "";

  setSignedIn(bool state) {
    signedIn = state;
    notifyListeners();
  }

  setSigningIn(bool state) {
    signingIn = state;
    notifyListeners();
  }

  setSigningUp(bool state) {
    signingUp = state;
    notifyListeners();
  }

  setAuthState(String state) {
    authState = state;
    notifyListeners();
  }

  getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString("accessToken") ?? "";
    if (token != "") {
      signedIn = true;
      print("Retrieved Access Token");
    }
    tokenChecked = true;
    notifyListeners();
  }

  Future<bool> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    setSigningIn(true);
    try {
      final response = await post(Uri.parse("${AppConstants.apiBase}/login"),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: {"username": email, "password": password});

      var resobj = jsonDecode(response.body) as Map;
      print(resobj);

      if (resobj.containsKey("access_token")) {
        accessToken = resobj["access_token"];

        await prefs.setString("accessToken", accessToken);
        signedIn = true;
        setSigningIn(false);
        return true;
      } else if (resobj.containsKey("detail")) {
        authErrors = "Could not sign in user";
        setSigningIn(false);
      }
      print(authErrors);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
    return false;
  }

  registerUser(
      String email, String password, String firstName, String lastName) async {
    setSigningUp(true);
    final response = await post(Uri.parse("${AppConstants.apiBase}/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "email_address": email,
          "password": password
        }));

    var resobj = jsonDecode(response.body) as Map;
    print(resobj);

    if (response.statusCode != 201) {
      authErrors = "Could not register in user";
      print(authErrors);
      return;
    }

    loginUser(email, password);

    notifyListeners();
  }
}
