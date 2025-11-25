import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider extends ChangeNotifier {
  String _emailId= "useremail.com";                  
  String _phoneNumber = "0123456789";
  String _location = 'India';
  String _company = 'company';
  String _countryCode = '+91';
  String _userName = "Suraj Chaubey";

  // ---------- Getters ----------
  String get emailId => _emailId;
  String get phoneNumber => _phoneNumber;
  String get location => _location;
  String get company => _company;
  String get countryCode => _countryCode;
  String get userName => _userName;


  set emailId(String value) {
    _emailId = value;
    notifyListeners();
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  set location(String value) {
    _location = value;
    notifyListeners();
  }

  set company(String value) {
    _company = value;
    notifyListeners();
  }

  set countryCode(String value) {
    _countryCode = value;
    notifyListeners();
  }

  set userName(String value) {
    _userName = value;
    notifyListeners();
  }


  Future<void> fetchUserInfo() async {
    final url = Uri.parse('http://192.168.0.142:8000/user_details');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _emailId = data['email_id'];
      _phoneNumber = data['phone_number'];
      _location = data['location'];
      _company = data['company'];
      _countryCode = data['country_code'];
      _userName = data["user_name"];
      notifyListeners();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  
}

