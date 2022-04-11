// 用于访问后端接口
import 'package:new_app/global/Global.dart';
import 'package:new_app/utils/rsa/rsa_utils.dart';

Future getItem() async{
  return await Global.getInstance().dio.get("/bookkeeping/item");
}
