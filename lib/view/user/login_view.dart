import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_app/base/view.dart';
import 'package:new_app/global/Global.dart';
import 'package:new_app/utils/rsa/rsa_utils.dart';
import 'package:new_app/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weui/button/index.dart';
import 'package:new_app/eventbus/event_bus.dart';
import 'package:weui/dialog/index.dart';
import 'package:weui/toast/index.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _user;
  TextEditingController _pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = new TextEditingController();
    _pass = new TextEditingController();
    bus.on("fail", (arg) {  // 订阅消息，来自viewmodel层
      if (arg["view"] == "login") {
        WeToast.fail(context)(message: arg["message"]);
      }
    });
    bus.on("alert", (arg) {  // 订阅消息，来自viewmodel层
      if (arg["view"] == "login") {
        WeDialog.alert(context)(arg["message"]);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 关闭两个控制器，节省资源
    _user.dispose();
    _pass.dispose();
    bus.off("fail"); // 关闭消息订阅
    bus.off("alert");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("登录"),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset(
              "images/main_show.jpg",
              width: double.infinity,
              height: 130,
              // fit: BoxFit.fill,
            ),
            SizedBox(height: 16,),
            // WeForm(
            //     children: [
            //       WeInput(
            //         autofocus: true,  // 自动获取光标
            //         label: "账号",
            //         hintText: "请输入账号",
            //         clearable: true,
            //         textInputAction: TextInputAction.next, // 输入法右侧按钮
            //       ),
            //       WeInput(
            //         label: "密码",
            //         hintText: "请输入密码",
            //         clearable: true,
            //         obscureText: true,
            //         textInputAction: TextInputAction.send,
            //         // footer: Icon(Icons.add),
            //       ),
            //     ]
            // ),
            TextField(
              decoration: InputDecoration(
                labelText: "账号",
                hintText: "请输入账号",
                prefix: Icon(Icons.person),
              ),
              controller: _user,  // 有控制器才能获取到值
              autofocus: true,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                prefix: Icon(Icons.lock)
              ),
              controller: _pass,
              obscureText: true,
              textInputAction: TextInputAction.send,
              onSubmitted: submit,
            ),
            SizedBox(height: 16,),
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: Text(
                  "找回密码",
                  style: TextStyle(color: Colors.blue),
                  textAlign: TextAlign.right,
                ),
              ),
              onTap: () {
                print("找回密码");
              },
            ),
            SizedBox(height: 16,),
            WeButton(
              "登录",
              // size: WeButtonSize.mini,
              theme: WeButtonType.primary,
              loading: Provider.of<LoginViewmodel>(context).getIsLogin,
              onClick: _login,
            ),
            SizedBox(height: 8,),
            WeButton(
              "注册",
              // size: WeButtonSize.mini,
              theme: WeButtonType.primary,
              onClick: _register,
            ),
          ],
        ),
      )
    );
  }

  void submit(String) {
    print("shubmit");
    print(String);
  }

  // 第一种传入上下文对象的方式
  void _login() async {
    context.read<LoginViewmodel>().login(_user.text, _pass.text);
  }

  void _register() {
    Navigator.of(context).pushNamed("register");
  }

  void loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    if (token != null) {
      Global.getInstance().dio.options.headers["token"] = token;
      context.read<LoginViewmodel>().tokenLogin(token);
    }
  }
}














