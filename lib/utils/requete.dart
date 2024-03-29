import 'package:get/get.dart';
//import 'package:dio/dio.dart' as d;
//final dio = d.Dio();

class Requete extends GetConnect {
  //static String url = "http://10.0.2.2:8080"; //
  //static String url = "http://192.168.100.134:8080"; //192.168.100.134
  static String url = "http://localhost:8080";
  //static String url = "http://192.168.0.100:8080";
  //192.168.1.190
  Future<Response> getE(String path) async {
    return get("$url/$path");
  }

  Future<Response> postE(String path, var e) async {
    print(e);
    return post(
      "$url/$path",
      e,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );
  }

  Future<Response> putE(String path, var e) async {
    return put("$url/$path", e);
  }

  Future<Response> deleteE(String path) async {
    return delete("$url/$path");
  }
}
