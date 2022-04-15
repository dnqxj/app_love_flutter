import 'package:flutter/material.dart';
import 'package:new_app/global/global_theme.dart';
import 'package:new_app/provider/app_provider.dart';
import 'package:new_app/routes/routes.dart';
import 'package:new_app/viewmodel/login_viewmodel.dart';
import 'package:new_app/viewmodel/register_viewmodel.dart';
import 'package:new_app/viewmodel/theme_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

int _color;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(MyApp());
  SharedPreferences sp = await SharedPreferences.getInstance();
  _color = await sp.getInt("color") ?? 0;
  ThemeViewmodel themeViewmodel = ThemeViewmodel();
  themeViewmodel.setColor(_color);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginViewmodel()),
          ChangeNotifierProvider(create: (context) => themeViewmodel),
          ChangeNotifierProvider(create: (context) => RegisterViewmodel()),
          ChangeNotifierProvider(create: (context) => AppProvider()),
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: themes[Provider.of<ThemeViewmodel>(context).getColor],
        buttonTheme: ButtonThemeData(
          buttonColor: themes[Provider.of<ThemeViewmodel>(context).getColor],
          textTheme: ButtonTextTheme.primary,
        )
      ),
      routes: routes,
      initialRoute: "/",
    );
  }
}
