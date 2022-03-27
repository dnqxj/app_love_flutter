// 用于访问后端接口
import 'package:new_app/global/Global.dart';

Future RegisterModel(Map<String, dynamic> data)async {
  return await Global.getInstance().dio.post("/user/register", data: data);
}
