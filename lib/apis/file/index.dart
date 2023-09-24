import 'package:love_app/global/Global.dart';

var dio = Global.getInstance().dio;

/**
 * 文件模块
 */
// 上传文件
Future upload(data) async {
  return await Global.getInstance().dio.post("/file/upload", data: data);
}
