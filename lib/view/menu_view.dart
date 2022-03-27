import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:new_app/base/view.dart';
import 'package:new_app/global/Global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weui/cell/index.dart';
import 'package:weui/form/index.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  String name = Global.getInstance().user["name"] != "" ? Global.getInstance().user["name"] : '未登录';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarActions("菜单", [
        IconButton(icon: Icon(Icons.settings), onPressed: () {
          Navigator.of(context).pushNamed("theme");
        })
      ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,  // 状态栏，空白问题
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("萧十一郎"),
                accountEmail: Text("12132@qq.com",),
              // currentAccountPicture: Text("data"),
            ),
            WeCell(
              label: "支出上限",
              content: Global.getInstance().user["money"].toString(),
              footer: Icon(Icons.navigate_next),
              onClick: () {

              },
            ),
            Divider(height: 1,),
            WeCell(
              label: "注册日期",
              content: Global.getInstance().user["date"],
              onClick: () {
                Navigator.pop(context);
              },
            ),
            Divider(height: 1,),
            WeCell(
              label: "记账",
              content: "开始记账",
              onClick: () {
                Navigator.of(context).pushNamed("accounting");
              },
            ),
            Divider(height: 1,),
            WeCell(
              label: "退出登录",
              content: "",
              footer: Icon(Icons.exit_to_app),
              onClick: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.remove("token");
                Navigator.of(context).popAndPushNamed("/");
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "http://via.placeholder.com/350x350",
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              child: Text("记账", style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pushNamed("accounting");
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              child: Text("相册", style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pushNamed("love");
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              child: Text("日期提醒", style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pushNamed("dateAlert");
              },
            ),
          )
        ],
      ),
    );
  }
}
