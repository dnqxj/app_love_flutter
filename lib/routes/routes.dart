import 'package:flutter/material.dart';
import 'package:new_app/view/accounting/accounting_add.dart';
import 'package:new_app/view/accounting/accounting_list.dart';
import 'package:new_app/view/album/love_view.dart';
import 'package:new_app/view/alert/date_alert.dart';
import 'package:new_app/view/user/login_view.dart';
import 'package:new_app/view/menu_view.dart';
import 'package:new_app/view/user/register_view.dart';
import 'package:new_app/view/theme/settings_theme.dart';

Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => LoginView(),
  "menu": (BuildContext context) => MenuView(),
  "register": (BuildContext context) => RegisterView(),
  "theme": (BuildContext context) => SettingsTheme(),
  "accounting": (BuildContext context) => AccountingView(),
  "accounting/add": (BuildContext context) => AccountingAddView(),
  "love": (BuildContext context) => LoveView(),
  "dateAlert": (BuildContext context) => DateAlertMenu(),
};