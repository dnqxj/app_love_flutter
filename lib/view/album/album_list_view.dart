import 'package:flutter/material.dart';
import 'package:new_app/base/view.dart';

class AlbumListView extends StatefulWidget {
  const AlbumListView({Key key}) : super(key: key);

  @override
  _AlbumListViewState createState() => _AlbumListViewState();
}

class _AlbumListViewState extends State<AlbumListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("相册列表"),
    );
  }
}
