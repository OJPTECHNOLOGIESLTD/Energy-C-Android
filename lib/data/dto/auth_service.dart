import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'https://energychleen.net/backend';

  // Registration API function
  Future<http.Response> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    String url = '$_baseUrl/register';

    Map<String, dynamic> data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    };

    // API call
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    );

    return response;
  }

    // Login API function
  // Future<http.Response> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   String url = '$_baseUrl/login';

  //   Map<String, dynamic> data = {
  //     'email': email,
  //     'password': password,
  //   };

  //   // API call
  //   var response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: json.encode(data),
  //   );

  //   return response;
  // }
}

