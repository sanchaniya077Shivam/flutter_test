import 'dart:convert';

import 'package:http/http.dart' as http;


class ApiServices {
  Future<dynamic> getRestournts() async {
    const url = 'https://codejudge-question-artifacts.s3.ap-south-1.amazonaws.com/q-1731/final.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
