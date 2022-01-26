import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//User authentication provider
class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  //Futures are widget that need input that has not been given by the user to run
  Future<void> signup(String email, String password) async {
    const url = "";

    //Http post via JSON format
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
  }
}
