import 'package:flutter/material.dart';
import 'package:new_app/view/album/album_list_view.dart';
import 'package:new_app/view/album/love_view.dart';
import 'package:new_app/view/moration_day/date_alert.dart';
import 'package:new_app/view/bookkeeping/book_add_view.dart';
import 'package:new_app/view/bookkeeping/book_list_view.dart';
import 'package:new_app/view/home/home_view.dart';
import 'package:new_app/view/love/love_index_view.dart';
import 'package:new_app/view/test.dart';
import 'package:new_app/view/user/login_view.dart';
import 'package:new_app/view/menu_view.dart';
import 'package:new_app/view/user/register_view.dart';
import 'package:new_app/view/theme/settings_theme.dart';

Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => LoginView(),
  "menu": (BuildContext context) => MenuView(),
  "register": (BuildContext context) => RegisterView(),
  "theme": (BuildContext context) => SettingsTheme(),
  "love": (BuildContext context) => LoveView(),
  "dateAlert": (BuildContext context) => DateAlertMenu(),
  "album_list": (BuildContext context) => AlbumListView(),
  "book_list":  (BuildContext context) => BookListView(),
  "book_add":  (BuildContext context) => BookAddView(),
  "home":  (BuildContext context) => HomeView(),
  "love_index": (BuildContext context) => LoveIndexVew(),
  "test": (BuildContext context) => TextDemo(),
};