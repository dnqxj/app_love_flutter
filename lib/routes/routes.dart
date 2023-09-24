import 'package:flutter/material.dart';
import 'package:love_app/view/album/album_add_view.dart';
import 'package:love_app/view/album/album_list_view.dart';
import 'package:love_app/view/album/love_view.dart';
import 'package:love_app/view/moration_day/date_alert.dart';
import 'package:love_app/view/bookkeeping/book_add_view.dart';
import 'package:love_app/view/bookkeeping/book_list_view.dart';
import 'package:love_app/view/home/home_view.dart';
import 'package:love_app/view/love/love_index_view.dart';
import 'package:love_app/view/test.dart';
import 'package:love_app/view/user/login_view.dart';
import 'package:love_app/view/menu_view.dart';
import 'package:love_app/view/user/register_view.dart';
import 'package:love_app/view/theme/settings_theme.dart';

Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => MenuView(),
  "menu": (BuildContext context) => MenuView(),
  "login": (BuildContext context) => LoginView(),
  "register": (BuildContext context) => RegisterView(),
  "home": (BuildContext context) => HomeView(),
  "theme": (BuildContext context) => SettingsTheme(),
  "love": (BuildContext context) => LoveView(),
  "dateAlert": (BuildContext context) => DateAlertMenu(),
  "album_list": (BuildContext context) => AlbumListView(),
  "album_add": (BuildContext context) => AlbumAddView(),
  "book_list": (BuildContext context) => BookListView(),
  "book_add": (BuildContext context) => BookAddView(),
  "love_index": (BuildContext context) => LoveIndexVew(),
  "test": (BuildContext context) => TextDemo(),
};
