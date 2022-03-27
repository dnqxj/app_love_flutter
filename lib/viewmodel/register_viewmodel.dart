import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_app/eventbus/event_bus.dart';
import 'package:new_app/model/register_model.dart';

import '../main.dart';

class RegisterViewmodel extends ChangeNotifier {
  bool _loading = false;

  bool get getLoading {
    return _loading;
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // 登录方法
  login(String user, String pass, String name, String phone, String code, int gender, String dateTime, int solar)async {

    Map<String, dynamic> map = Map();
    map['username'] = user;
    map['password'] = pass;
    map['name'] = name;
    map['phone'] = phone;
    map['code'] = code;
    map['dateTime'] = dateTime;
    map['gender'] = gender;
    map['solar'] = solar;
    print(map);
    setLoading(true);
    Response result = await RegisterModel(map);
    print(result);
    if (result.data['status'] == 'success') {
      //  3s后跳转菜单界面
      new Timer(Duration(seconds: 2), () {
        setLoading(false);
        // 跳转时可以使用全局 navigatorKey
        Navigator.of(navigatorKey.currentContext).popAndPushNamed("menu");
      });
    } else {
      bus.emit("alert", {
        "view": "login",
        "message": result.data['message']
      });
      setLoading(false);
    }
  }
}