import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "http://192.168.1.6:8081/api/v1";

  String getBasicAuthenticationHeader(String username, String password) {
    String valueToEncode = '$username:$password';
    String encodedValue = base64Encode(utf8.encode(valueToEncode));
    return 'Basic $encodedValue';
  }

  Future<http.Response> sendRequest(
      String endpoint,
      String method,
      {dynamic body}
      ) async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? "";
    String password = prefs.getString('password') ?? "";
    final headers = {
      'Authorization': getBasicAuthenticationHeader(username, password),
      'Content-Type': 'application/json',
    };
    final url = Uri.parse('$baseUrl$endpoint');

    http.Response response;

    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(url, headers: headers);
        break;
      case 'POST':
        response = await http.post(url, headers: headers, body: body != null ? jsonEncode(body) : null);
        break;
      case 'PUT':
        response = await http.put(url, headers: headers, body: body != null ? jsonEncode(body) : null);
        break;
      case 'DELETE':
        response = await http.delete(url, headers: headers);
        break;
      default:
        throw UnsupportedError('Method $method is not supported');
    }

    return response;
  }
}
