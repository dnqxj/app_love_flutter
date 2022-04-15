import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_app/base/view.dart';
import 'package:new_app/global/Global.dart';

class DateAlertList extends StatefulWidget {
  const DateAlertList({Key key}) : super(key: key);

  @override
  _DateAlertListState createState() => _DateAlertListState();
}

class _DateAlertListState extends State<DateAlertList> {
  List _dateList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("日期提醒"),
      body: ListView.builder(itemBuilder: _itemBuilder, itemCount: _dateList != null ? _dateList.length : 0,)
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(_dateList[index]['name'].toString() + "生日：" + _dateList[index]['date'].toString()),
    );
  }

  void loadData() async {
    // var res = await Global.getInstance().dio.get("/love/date_list");
    // print(res);
    // if(res.data["status"] == 'success') {
    //   setState(() {
    //     _dateList = res.data['data'];
    //   });
    // } else {
    //   EasyLoading.showError(res.data['message']);
    // }
  }
}
