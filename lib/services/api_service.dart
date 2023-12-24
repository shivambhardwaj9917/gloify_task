import 'package:dio/dio.dart';
import 'package:gloify_task/models/home_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final apiUrl = "";

  Future<dynamic> postData(List<Note> list) async {
    try {
      final response = await _dio.post(apiUrl, data: list);
      if(response.statusCode == 200) {
        return "Success";
      }
      return "Failure";
    } catch (error) {
      return "Failure";
    }
  }
}