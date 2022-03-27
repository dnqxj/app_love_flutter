import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_app/eventbus/event_bus.dart';
import 'package:new_app/global/Global.dart';
import 'package:new_app/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

// 管理状态，并全局通知（订阅表）
class AccountingViewmodel extends ChangeNotifier {
  bool _isLogin = false;

  bool get getIsLogin {
    return _isLogin;
  }

  void setIsLogin (bool value){
    _isLogin = value;
    notifyListeners();
  }

  // 第一种传入上下文对象的方式
  void login(String user, String pass)async {
    // 持久化操作实例
    SharedPreferences sp = await SharedPreferences.getInstance();

    setIsLogin(true);
    if (user.isEmpty) {
      bus.emit("fail", {
        "view": "login",
        "message": "账号不能为空"
      });
      setIsLogin(false);
      return;
    } else if (pass.isEmpty) {
      // 全局navigatorKey 中的上下文对象
      bus.emit("fail", {
        "view": "login",
        "message": "密码不能为空"
      });
      setIsLogin(false);
      return;
    }

    Response result = await loginModel(user, pass);
    print(result);
    if (result.data['status'] == 'success') {
      Global.getInstance().token = result.data["data"]["token"];
      Global.getInstance().user = result.data["data"]["user"];
      // 持久化操作
      sp.setString("token", result.data["data"]["token"]);
      Global.getInstance().dio.options.headers["token"] = result.data["data"]["token"];
      //  3s后跳转菜单界面
      new Timer(Duration(seconds: 2), () {
        setIsLogin(false);
        // 跳转时可以使用全局 navigatorKey
        Navigator.of(navigatorKey.currentContext).popAndPushNamed("menu");
      });
    } else {
      bus.emit("alert", {
        "view": "login",
        "message": result.data['message']
      });
      // WeDialog.alert(context)(result.data['message']);
      setIsLogin(false);
    }
  }

  void tokenLogin(String token)async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // 检查token是否正确
    Response result = await tokenLoginModel(token);
    if (result.data["status"] == "success") {
      Global.getInstance().user = result.data["data"];
      // 使用全局的上下文对象
      Navigator.of(navigatorKey.currentContext).popAndPushNamed("menu");
    } else {
      sp.remove("token");
    }
  }
}