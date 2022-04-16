import 'package:new_app/global/Global.dart';

var dio = Global.getInstance().dio;

/**
 * 记账模块
 */
// 查询月份详情
Future monthDetails(data)async {
  return await Global.getInstance().dio.get("/bookeep/month_details", queryParameters: data);
}

// 新增账务记录
Future add(data)async {
  return await Global.getInstance().dio.post("/bookeep/add", data: data);
}

// 修改账务记录
Future update(data)async {
  return await Global.getInstance().dio.post("/bookeep/update", data: data);
}

// 删除财务记录
Future delete(data)async {
  return await Global.getInstance().dio.post("/bookeep/delete", data: data);
}