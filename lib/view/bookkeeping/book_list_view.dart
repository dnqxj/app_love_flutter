import 'package:flutter/material.dart';

import 'package:new_app/apis/bookeep/index.dart' as BookeepApi;
import 'package:new_app/provider/app_provider.dart';
import 'package:new_app/utils/alert_utils.dart';
import 'package:provider/provider.dart';

class BookListView extends StatefulWidget {
  const BookListView({Key key}) : super(key: key);

  @override
  _BookListViewState createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  // init data
  int _month;
  var _dayList = [];
  var _info = {};

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 获取全局状态数据，用户数据
    final appProvider = Provider.of<AppProvider>(context);
    var _userInfo = appProvider.userInfo;
    print(_userInfo);

    return Scaffold(
      appBar: AppBar(
        title: Text("记账"),
        centerTitle: true,
        elevation: 10, // 阴影
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      _info["year"].toString() + "年",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        child: Text(
                      "预算",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        child: Text(
                      "收入",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        child: Text(
                      "支出",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      child: Text(
                        _info["month"].toString() + "月",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onTap: _getMonth,
                    )),
                    Expanded(
                        child: Text(
                      _userInfo["money"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
                    Expanded(
                        child: Text(
                      _info["incomeTotal"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
                    Expanded(
                        child: Text(
                      _info["expenditureTotal"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: true, // 根据子组件的高度
          itemBuilder: _itemBuilder,
          itemCount: _dayList.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _add,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  // to-do，等待数据
  Widget _itemBuilder(BuildContext context, int index) {
    var itemData = _dayList[index];
    var children = itemData["children"];
    var date = itemData["date"];
    var expenditure = itemData["expenditure"];
    var income = itemData["income"];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  date.toString(),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  "收入：" + expenditure.toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  "支出：" + income.toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Column(
          children: _childrens(children),
        ),
      ],
    );
  }

  // 每日记账详情数据
  List<Widget> _childrens(dayBookData) {
    List<Widget> widgets = [];
    for (var i = 0; i < dayBookData.length; i++) {
      var itemData = dayBookData[i];
      widgets.add(Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemData['type'] == 'expenditure' ? '支出' : '收入'),
                  Text(
                    "描述：" + itemData['details'],
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
              Text(itemData['total'].toString())
            ],
          )));
    }
    return widgets;
  }

  void loadData() async {
    // _month 未定义，获取当月
    if (_month == null) {
      _month = DateTime.now().month;
    }
    var params = {"year": DateTime.now().year, "month": _month};
    var result = await BookeepApi.monthDetails(params);
    print(result);
    if (result.data["success"]) {
      var data = result.data["data"];
      var info = data["info"];
      var dayList = data["dayList"];
      setState(() {
        _info = info;
        _dayList = dayList;
      });
    } else {
      await showAlertDialog(context, "错误", result.data['message']);
    }
  }

  void _getMonth() {
    List list = [];
    for (var i = 1; i <= 12; i++) {
      if (i <= DateTime.now().month) {
        list.add(i);
      } else {
        break;
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: list.map((e) {
            return SimpleDialogOption(
              child: Text(e.toString() + "月"),
              onPressed: () {
                _month = e; // 给全局data赋值，重新获取
                Navigator.pop(context); // 关闭弹窗
                loadData();
              },
            );
          }).toList(),
        );
      },
      barrierDismissible: false,
    );
  }

  void _add() async {
    var result = await Navigator.of(context).pushNamed("book_add");
    if (result != null && result == 'refresh') {
      loadData();
    }
  }
}
