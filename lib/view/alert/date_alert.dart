import 'package:flutter/material.dart';
import 'package:new_app/eventbus/event_bus.dart';
import 'package:new_app/view/alert/date_alert_add.dart';
import 'package:new_app/view/alert/date_alert_list.dart';

class DateAlertMenu extends StatefulWidget {
  const DateAlertMenu({Key key}) : super(key: key);

  @override
  _DateAlertMenuState createState() => _DateAlertMenuState();
}

class _DateAlertMenuState extends State<DateAlertMenu> with SingleTickerProviderStateMixin{
  List<Widget> _widgets = [DateAlertList(), DateAlertAdd()];
  TabController _controller;

  @override
  void initState() {
    // 订阅切换列表
    bus.on("addDateAfterToList", (arg) {
      _controller.animateTo(arg);
    });
    _controller = new TabController(length: _widgets.length, vsync: this); // 这地方绑定this，需要with
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    bus.off("addDateAfterToList");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("日期提醒"),
        centerTitle: true,
        elevation: 10,
      //  顶部tab页
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              text: '列表',
              // icon: Icon(Icons.list),
            ),
            Tab(
              text: '新增',
              // icon: Icon(Icons.add),
            ),
          ],
        )
      ),
      body: TabBarView(
        controller: _controller,
        children: _widgets,
      ),
    );
  }
}
