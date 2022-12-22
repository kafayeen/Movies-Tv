import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://api.themoviedb.org/3/movie/",
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getFuture({
    required String path,
  }) async {
    return await dio.get(path,
        queryParameters: {"api_key": "d2401014d19754551d7d1e71242f909b"});
  }
}
