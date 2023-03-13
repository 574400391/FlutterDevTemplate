import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dev_template/config/constant.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';

/// Api示例
///   实际项目中可能会调用多个平台的接口，因此未封装统一的Request请求类
///   每个平台的接口Api封装时需根据业务场景自行配置url、mock、超时、拦截器、刷新token等
///
/// ps: Dio 5.0版本已废弃lock()和unlock()方法，刷新token时可使用QueuedInterceptor阻塞dio网络请求
///    参考：https://github.com/cfug/dio/issues/1308
///    示例：https://github.com/cfug/dio/blob/main/example/lib/queued_interceptor_crsftoken.dart
class ExampleApi {
  final String _tag = "ExampleApi";
  static final ExampleApi _instance = ExampleApi._internal();

  // 用于业务接口调用
  static Dio? _dio;

  static ExampleApi getInstance() => _instance;

  static String baseUrl = Constant.exampleApiBaseUrl;

  ExampleApi._internal() {
    Log.d('_internal baseUrl: $baseUrl', tag: _tag);
    if (null == _dio) {
      BaseOptions baseOptions = BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 6),
          receiveTimeout: const Duration(seconds: 6));
      _dio = Dio(baseOptions);
      _dio!.interceptors.add(InterceptorsWrapper(onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        Log.d(
            'baseUrl: ${options.baseUrl}, path: ${options.path}, data: ${options.data}',
            tag: _tag,
            saveLog: true);
        handler.next(options);
      }, onResponse: (
        Response response,
        ResponseInterceptorHandler handler,
      ) async {
        Log.d('onResponse: ${response.data?.toString()}',
            tag: _tag, saveLog: true);
        handler.next(response);
      }, onError: (
        DioError e,
        ErrorInterceptorHandler handler,
      ) {
        Log.d("interceptors onError: ${e.error?.toString()}",
            tag: _tag, saveLog: true);
        handler.resolve(
            Response(data: "{}", requestOptions: RequestOptions(path: "")));
      }));
    }
  }
}
