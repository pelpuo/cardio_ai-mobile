import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';

class CardioAPI {
  getRequest(String url, String accessToken) async {
    try {
      print("getting ${AppConstants.apiBase}$url");
      final response =
          await get(Uri.parse("${AppConstants.apiBase}$url"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 200) {
        var temp = jsonDecode(response.body);
        return temp;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  postRequest() {}
}
