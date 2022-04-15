import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  String _token = "";
  bool _isLogin = false;
  Map _userInfo = {};



  String get token => _token;

  void setToken(String value)async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", value);
    _token = value;
    notifyListeners();
  }

  bool get isLogin => _isLogin;

  void setIsLogin(bool value)async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("isLogin", value);
    _isLogin = value;
    notifyListeners();
  }

  get userInfo => _userInfo;

  // 设置用户info
  void setUserInfo(Map userInfo)async {
    // 持久化保持
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("userInfo", userInfo.toString());
    _userInfo = userInfo;
    notifyListeners();
  }


}