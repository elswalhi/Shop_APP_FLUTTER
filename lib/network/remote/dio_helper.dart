import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
class DioHelper {
  static late Dio dio;
  static init(){
    dio= Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,

      ),
    );

  }
 static Future<Response?> getData({
    @required String? url,
     Map<String, dynamic> ?quary,
    String lang = 'en',
    String? token,
  })async{
   dio.options.headers = {
     'lang':lang,
     'Authorization':token??'',
     "Content-Type":"application/json"
   };
    return await dio.get(url!,queryParameters:quary);
  }


  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  })async{
    dio.options.headers = {
      'lang':lang,
    "Content-Type":"application/json",
      'Authorization':token,
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  })async{
    dio.options.headers = {
      'lang':lang,
      "Content-Type":"application/json",
      'Authorization':token,
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

}