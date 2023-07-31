import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>>? get({required String url}) async {
    Map<String, dynamic> responseData = <String, dynamic>{};
    try {
      final Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        responseData = response.data;
      } else {
        print('Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return responseData;
  }

  Future<Map<String, dynamic>?> post(String url,
      {required Map<String, dynamic> data}) async {
    try {
      final Response response = await _dio.post(url, data: data);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}
