import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  
  static const String apiKey = "aE01FqRR1IhaiYGyV56QAOLP5bCAjmIZ";
  static const String baseUrl = "https://app.ticketmaster.com/discovery/v2/";

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    Map<String, dynamic> finalQuery = {
      'apikey': apiKey,
    };
    
    if (query != null) {
      finalQuery.addAll(query);


      
    }

    return await dio.get(
      url,
      queryParameters: finalQuery,
    );
  }
}
