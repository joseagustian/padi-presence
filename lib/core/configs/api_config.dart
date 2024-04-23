import 'package:http/http.dart' as http;

class ApiConfig {

  final String baseUrl = "https://padi-xi.vercel.app/api/v1";
  final String apiKey = "p@di@2023";


}

class ApiRequest {

  ApiConfig apiConfig = ApiConfig();

  Future<http.Response> post(String endpoint, dynamic body, String? token) async {
    final response = await http.post(
      Uri.parse('${apiConfig.baseUrl}$endpoint'),
      headers: {
        'API-KEY': apiConfig.apiKey,
        'Content-Type': 'application/json',
        'token': token?? '',
      },
      body: body,
    );
    return response;
  }

  Future<http.Response> get(String endpoint, String? token) async {
    final response = await http.get(
      Uri.parse('${apiConfig.baseUrl}$endpoint'),
      headers: {
        'API-KEY': apiConfig.apiKey,
        'Content-Type': 'application/json',
        'token': token?? '',
      },
    );
    return response;
  }

}