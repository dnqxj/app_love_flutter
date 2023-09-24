import 'package:love_app/global/Global.dart';

var dio = Global.getInstance().dio;

Future getDateList(String date) async {
  return await dio.get("/bookkeeping/item", queryParameters: {"date": date});
}
