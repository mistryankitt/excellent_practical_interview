import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response?> getApi({endPoint}) async {
    try {
      final response = await http.get(Uri.parse(endPoint));
      return response;
    } catch (e) {
      log("Error while getting data is $e");
    }
  }
}
