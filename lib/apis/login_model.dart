// 用于访问后端接口
import 'package:love_app/global/Global.dart';
import 'package:love_app/utils/rsa/rsa_utils.dart';

Future loginModel(String user, String pass) async {
  String username = user;
  String password = await encodeString(pass);
  Map<String, dynamic> map = Map();
  map['username'] = username;
  map['password'] = password;
  return await Global.getInstance().dio.post("/user/login", data: map);
}

Future tokenLoginModel(String token) async {
  return await Global.getInstance().dio.post("/user/checkToken");
}

// get
// Map<String,dynamic> map = Map();
// map["userId"]= userId;
// ///发起get请求
// Response response = await dio.get(url3,queryParameters: map);

///发送 FormData:
// FormData formData = FormData.fromMap({"name": "张三", "age": 22});
// String url ="http://192.168.200.68:8080/registerUser";
// ///发起 post 请求 如这里的注册用户信息
// Response response = await dio
//     .post(url, data: formData);
