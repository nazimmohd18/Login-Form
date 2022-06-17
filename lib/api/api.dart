import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static Future getMedicine() async {
    final response = await http
        .get(Uri.parse('https://run.mocky.io/v3/7dc67710-4c72-4c37-8474-87f67d92bdc9'), headers: <String, String>{
      'accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  }
}
