import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apps_api/model/school_model.dart';

class ApiService {
  final String apiUrl = "https://api-sekolah-indonesia.vercel.app/sekolah?page=1&perPage=5";

  Future<List<School>> fetchSchools() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      if (decodedData['dataSekolah'] != null) {
        List<dynamic> body = decodedData['dataSekolah'];
        return body.map((json) => School.fromJson(json)).toList();
      } else {
        throw Exception("No data available");
      }
    } else {
      throw Exception("Failed to load schools");
    }
  }
}
