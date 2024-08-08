import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRequest {

  final baseUrl = dotenv.env['BASE_URL'];
  final apiKey = dotenv.env['API_KEY'];


  Future<http.Response> post(String endpoint, dynamic body, String? token) async {

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'API-KEY': '$apiKey',
        'Content-Type': 'application/json',
        'token': token?? '',
      },
      body: body,
    );
    return response;
  }

  Future<http.Response> get(String endpoint, String? token) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'API-KEY': '$apiKey',
        'Content-Type': 'application/json',
        'token': token?? '',
      },
    );
    return response;
  }

}