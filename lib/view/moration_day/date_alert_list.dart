import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:love_app/base/view.dart';
import 'package:love_app/global/Global.dart';
import 'package:love_app/global/global_theme.dart';
import 'package:love_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

class DateAlertList extends StatefulWidget {
  const DateAlertList({Key key}) : super(key: key);

  @override
  _DateAlertListState createState() => _DateAlertListState();
}

class _DateAlertListState extends State<DateAlertList> {
  List _dateList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _dateList.add({
        "name": "hello${i}",
        "date": "2021-01-01",
        "dateType": i % 2 == 0 ? "生日" : "纪念日",
        "countDown": 1 + i
      });
    }
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final _themeColor = themes[Provider.of<AppProvider>(context).themeColor];
    return Container(
        padding: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            Container(
              height: 90,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("100",
                          style: TextStyle(
                              fontSize: 26,
                              color: _themeColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("天"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("距离恋爱纪念日",
                      style: TextStyle(fontSize: 16, color: Colors.black54))
                ],
              ),
            ),
            Expanded(
                child: Container(
              height: 200,
              child: ListView.builder(
                itemBuilder: _itemBuilder,
                itemCount: _dateList != null ? _dateList.length : 0,
              ),
            ))
          ],
        ));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final _themeColor = themes[Provider.of<AppProvider>(context).themeColor];
    TextStyle _valueStyle = TextStyle(color: Colors.black54);
    // const name = _dateList[index]['name'];
    // const date = _dateList[index]['date'];
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "姓名：",
                      style: _valueStyle,
                    ),
                    Text("刘亦菲")
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "生日：",
                      style: _valueStyle,
                    ),
                    Text("1995-05-12")
                  ],
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  "距离纪念日还有",
                  style: _valueStyle,
                ),
                Text(
                  "100",
                  style: TextStyle(color: _themeColor),
                ),
                Text(
                  "天",
                  style: _valueStyle,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
            )
          ],
        ));
  }

  void loadData() async {
    // var res = await Global.getInstance().dio.get("/love/date_list");
    // print(res);
    // if(res.data["success"]) {
    //   setState(() {
    //     _dateList = res.data['data'];
    //   });
    // } else {
    //   EasyLoading.showError(res.data['message']);
    // }
  }
}
