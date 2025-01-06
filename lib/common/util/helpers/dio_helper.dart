import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'logger_interceptor_v2.dart';
import 'token_interceptor.dart';

class DioNetwork {
  final List<Interceptor> interceptors;
  final String baseUrl;
  static late Dio dio;

  DioNetwork({this.interceptors = const [], required this.baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio.options.headers = {'Accept': 'application/json'};
    dio.interceptors.addAll([LoggerInterceptorV2(), TokenInterceptor(), ...interceptors]);
  }

  Future<dynamic> _prepareRequestData(Map<String, dynamic> data) async {
    bool hasFile = data.values.any((value) => value is File || value is Uint8List || value is List<File>);
    if (hasFile) {
      FormData formData = FormData();
      for (var entry in data.entries) {
        final key = entry.key;
        final value = entry.value;
        if (value is File || value is List<File>) {
          if (value is File) {
            formData.files.add(await _handleFile(key, value));
          } else {
            for (var file in value) {
              formData.files.add(await _handleFile(key, file));
            }
          }
        } else if (value is Uint8List) {
          formData.files.add(MapEntry(key, MultipartFile.fromBytes(value, filename: 'uploaded_file')));
        } else {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      }
      return formData;
    }
    return data;
  }

  // Helper method to handle file upload
  Future<MapEntry<String, MultipartFile>> _handleFile(String key, File file) async {
    String fileName = file.path.split('/').last;
    return MapEntry(key, await MultipartFile.fromFile(file.path, filename: fileName));
  }

  // Request method for POST
  Future<Response> postData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    dio.options.headers.addAll(headers ?? {});
    dynamic requestData = await _prepareRequestData(data);
    return await dio.post(endPoint, data: requestData, queryParameters: params);
  }

  // Request method for PUT
  Future<Response> putData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    dio.options.headers.addAll(headers ?? {});
    dynamic requestData = await _prepareRequestData(data);
    return await dio.put(endPoint, data: requestData, queryParameters: params);
  }

  // Request method for DELETE
  Future<Response> deleteData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    dio.options.headers.addAll(headers ?? {});
    return await dio.delete(endPoint, data: data, queryParameters: params);
  }

  // Request method for GET
  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers.addAll(headers ?? {});
    return await dio.get(endPoint, queryParameters: params, data: data);
  }
}
