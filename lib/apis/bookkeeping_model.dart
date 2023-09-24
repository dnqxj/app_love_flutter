// 用于访问后端接口
import 'package:love_app/global/Global.dart';
import 'package:love_app/utils/rsa/rsa_utils.dart';

Future getItem() async {
  return await Global.getInstance().dio.get("/bookkeeping/item");
}
