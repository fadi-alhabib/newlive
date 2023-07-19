import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "http://fadialhabib-001-site1.atempurl.com/api/",
    ));
  }

  static Future<Response?> getData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      String? token}) async {
    return await dio?.get(path,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  static Future<Response?> postData(
      {required String path,
      required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      String? token}) async {
    return await dio?.post(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
