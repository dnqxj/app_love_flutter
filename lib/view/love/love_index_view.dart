import 'package:flutter/material.dart';
import 'package:new_app/base/view.dart';

class LoveIndexVew extends StatefulWidget {
  const LoveIndexVew({Key key}) : super(key: key);

  @override
  _LoveIndexVewState createState() => _LoveIndexVewState();
}

class _LoveIndexVewState extends State<LoveIndexVew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("恋爱"),
    );
  }
}
