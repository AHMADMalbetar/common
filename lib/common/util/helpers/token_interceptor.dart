import 'dart:ui';

import 'package:dio/dio.dart';

import '../../const/app_consts.dart';
import 'shared_preferences_helper.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await SharedPreferencesHelper.getData(key: AppKeys.token);
      final lang = await SharedPreferencesHelper.getData(key: AppKeys.langNo);

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        print('TokenInterceptor: No token found');
      }

      options.headers['App-Language'] = (lang != null && lang == 0) ? 'sa' : 'en';

    } catch (e) {
      print('TokenInterceptor Error: $e');
    }

    super.onRequest(options, handler);
  }
}
