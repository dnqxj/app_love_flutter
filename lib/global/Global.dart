import 'package:dio/dio.dart';
import 'package:new_app/config/env.dart';

// 全局类
class Global {
  static Global _instance;
  Dio dio;

  Global() {
    dio = new Dio();
    dio.options = BaseOptions(
      baseUrl: Env.envConfig.appDomain, // 环境变量中的值
      connectTimeout: 5000, // 连接
      sendTimeout: 5000, // 发送
      receiveTimeout: 5000, // 响应
      // headers: {
      //   "token": "cxjlkjgfrdilejflidsfds"'
      // },
      contentType: Headers.jsonContentType, // 请求类型554
      responseType: ResponseType.json, // 响应类型
    );
    // 拦截器
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options) {
      // print('请求' + options.headers.toString());
      // print('请求' + options.extra.toString());
    }, onResponse: (e) {
      // print("返回" + e.toString());
    }, onError: (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        print("连接超时错误");
      } else {
        print("接口错误~");
        print(e.toString());
      }
    }));
  }

  static Global getInstance() {
    if (_instance == null) _instance = new Global();
    return _instance;
  }
}
