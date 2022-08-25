import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:new_app/base/view.dart';
import 'package:new_app/global/global_theme.dart';
import 'package:new_app/provider/app_provider.dart';
import 'package:new_app/utils/data_utils.dart';
import 'package:provider/provider.dart';
import 'package:weui/cell/index.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final _themeColor = themes[Provider.of<AppProvider>(context).themeColor];
    TextStyle _labelStyle = TextStyle(fontSize: 16, color: Colors.black54);
    TextStyle _valueStyle = TextStyle(fontSize: 20);

    // 获取全局状态数据，用户数据
    final appProvider = Provider.of<AppProvider>(context);
    var userInfo = appProvider.userInfo;
    return Scaffold(
      appBar: getAppBarActions("菜单", [
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("theme");
            })
      ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // 状态栏，空白问题
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userInfo["name"]),
              accountEmail: Text(userInfo["email"]),
              // currentAccountPicture: Text("data"),
            ),
            Divider(
              height: 1,
            ),
            WeCell(
              label: "注册日期",
              content: timeStampToYMD(userInfo["createTime"]),
              onClick: () {
                Navigator.pop(context);
              },
            ),
            WeCell(
              label: "支出上限",
              content: userInfo["money"].toString(),
              footer: Icon(Icons.navigate_next),
              onClick: () {},
            ),
            Divider(
              height: 1,
            ),
            WeCell(
              label: "恋爱对象",
              content: "设置对象",
              footer: Icon(Icons.navigate_next),
              onClick: () {
                // to-do 设置对象
                // Navigator.of(context).pushNamed("accounting");
              },
            ),
            Divider(
              height: 1,
            ),
            WeCell(
              label: "退出登录",
              content: "",
              footer: Icon(Icons.exit_to_app),
              onClick: () async {
                context.read<AppProvider>().logout();
                Navigator.of(context).popAndPushNamed("login");
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "http://app.orangemust.com:8085/upload/2022/08/25/34ee2aea01944e59c7447a66542c5e74.jpg",
                  fit: BoxFit.cover,
                  height: 150,
                );
              },
              itemCount: 3,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "提醒",
                  style: TextStyle(fontSize: 20),
                ),
              ),
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
              Text("距离恋爱纪念日", style: _labelStyle)
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "财务",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "本月预算：",
                    style: _labelStyle,
                  ),
                  Text(
                    "2000",
                    style: _valueStyle,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "本月收入：",
                    style: _labelStyle,
                  ),
                  Text(
                    "257",
                    style: _valueStyle,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "本月支出：",
                    style: _labelStyle,
                  ),
                  Text(
                    "582",
                    style: _valueStyle,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
