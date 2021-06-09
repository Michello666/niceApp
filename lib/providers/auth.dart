import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
  }

  _authenticate(String email, String pass, String urlSegment) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyC5OQ6FyU4gr76KBK_TM0tqFREjVEfFUOc");

    final response = await http.post(
      url,
      body: json.encode(
        {
          "email": email,
          "password": pass,
          "returnSecureToken": true,
        },
      ),
    );
    print(json.decode(response.body));
    final responseData = json.decode(response.body);
    _token = responseData["idToken"];
    _userId = responseData["localId"];
    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(
          responseData["expiresIn"],
        ),
      ),
    );
    notifyListeners();
  }

  Future<void> signUp(String email, String pass) async {
    return _authenticate(email, pass, "signUp");
  }

  Future<void> signIn(String email, String pass) async {
    return _authenticate(email, pass, "signInWithPassword");
  }

  void logOut() {
    if (isAuth) {
      _token = null;
      _userId = null;
      _expiryDate = null;
      notifyListeners();
    }
  }
}
