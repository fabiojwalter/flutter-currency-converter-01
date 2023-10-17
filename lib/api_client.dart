import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final Dio _dio = Dio();
  final logger = Logger();

  Future<Map<String, dynamic>>? get({required String url}) async {
    Map<String, dynamic> responseData = <String, dynamic>{};
    try {
      _dio.options.headers['Access-Control-Allow-Origin'] =
          'https://aaurus-converter.vercel.app';
      _dio.options.headers['Access-Control-Allow-Methods'] =
          'GET, POST, OPTIONS';
      _dio.options.headers['Access-Control-Allow-Headers'] =
          'Origin, Content-Type, Accept';
      final Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        responseData = response.data;
      } else {
        logger.e('Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error occurred: $e');
    }
    return responseData;
  }

  Future<Map<String, dynamic>?> post(String url,
      {required Map<String, dynamic> data}) async {
    try {
      final Response response = await _dio.post(url, data: data);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      logger.e('Error occurred: $e');
      return null;
    }
  }
}
