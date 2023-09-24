import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_app/apis/file/index.dart' as FileApi;
import 'package:love_app/base/view.dart';
import 'package:love_app/config/env.dart';
import 'package:love_app/global/global_theme.dart';
import 'package:love_app/provider/app_provider.dart';
import 'package:love_app/utils/alert_utils.dart';
import 'package:provider/provider.dart';

class LoveIndexVew extends StatefulWidget {
  const LoveIndexVew({Key key}) : super(key: key);

  @override
  _LoveIndexVewState createState() => _LoveIndexVewState();
}

class _LoveIndexVewState extends State<LoveIndexVew> {
  TextEditingController _love_acount;
  TextEditingController _romantic_things;
  List _loveItemList = null;

  String _uploadImageUrlPath = null;
  final ImagePicker _picker = ImagePicker();
  String _resourcesUuid = "";

  @override
  void initState() {
    _love_acount = new TextEditingController();
    _romantic_things = new TextEditingController();
    _loveItemList = [
      {"label": "一起看电影", "vallue": 1, "checked": true},
      {"label": "一起爬山", "vallue": 2, "checked": true},
      {"label": "一起看日出", "vallue": 3, "checked": true},
    ];
    super.initState();
  }

  @override
  void dispose() {
    _love_acount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _have_friend = true;
    return _have_friend
        ? haveFriendWidget()
        // 没有对象
        : singlewidget();
  }

  // 有对象
  Widget haveFriendWidget() {
    final _themeColor = themes[Provider.of<AppProvider>(context).themeColor];
    bool have_love_date = true;
    return Scaffold(
        appBar: getAppBar("我们恋爱了"),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  child: _uploadImageUrlPath == null
                      ? Container(
                          width: 300,
                          height: 150,
                          decoration: BoxDecoration(
                            // 装饰背景
                            // 背景色
                            color: Color.fromARGB(255, 251, 253, 255),
                            // 圆角
                            borderRadius: BorderRadius.circular(10),
                            // 边框
                            border: Border.all(
                              color: Colors.black26,
                              width: 1,
                            ),
                            // 阴影
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.pink,
                            //     blurRadius: 5.0
                            //   ),
                            // ],
                            // 背景图片
                            // image: DecorationImage(
                            //   image: NetworkImage("http://via.placeholder.com/350x350"),
                            //   alignment: Alignment.centerLeft
                            // )
                          ),
                          child: Icon(
                            Icons.add,
                            size: 64,
                            color: Colors.black26,
                          ),
                        )
                      : Image.network(
                          _uploadImageUrlPath,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                  onTap: _getImage,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              have_love_date
                  ? Container(
                      child: Column(
                        children: [
                          Text("古力娜扎"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("我们恋爱"),
                              Text(
                                "100",
                                style: TextStyle(color: _themeColor),
                              ),
                              Text("天了"),
                            ],
                          )
                        ],
                      ),
                    )
                  : Text("去日期提醒添加恋爱纪念日"),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("打卡浪漫的事"),
                  OutlinedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("添加"),
                            content: TextField(
                              decoration: InputDecoration(
                                hintText: "请输入浪漫的事",
                              ),
                              controller: _romantic_things, // 有控制器才能获取到值
                              textInputAction: TextInputAction.done,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  '确认',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  print(_romantic_things.text);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      '添加',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true, // 根据子组件的高度
                itemBuilder: _loveItemBuilder,
                itemCount: _loveItemList == null ? 0 : _loveItemList.length,
              ))
            ])));
  }

  //
  Widget _loveItemBuilder(BuildContext context, int index) {
    final _themeColor = themes[Provider.of<AppProvider>(context).themeColor];
    var item = _loveItemList[index];
    return Row(
      children: [
        Checkbox(
          activeColor: _themeColor,
          checkColor: Colors.white,
          value: item["checked"],
          onChanged: (bool value) {
            setState(() {
              _loveItemList[index]["checked"] = value;
            });
          },
        ),
        Text(item["label"])
      ],
    );
  }

  // 单身时展示的页面
  Widget singlewidget() {
    return Scaffold(
        appBar: getAppBar("我们恋爱了"),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset(
                "images/main_show.jpg",
                width: double.infinity,
                height: 130,
                // fit: BoxFit.fill,
              ),
              SizedBox(
                height: 16,
              ),
              Flexible(
                child: Text(
                  "在此添加你的恋人，填写你的恋人的账户登录名称，对方在当前页面输入你的账号名称后即可建立关系",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "请输入你对象的账号",
                ),
                controller: _love_acount, // 有控制器才能获取到值
                autofocus: true,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _submitLoveAccount,
                  child: const Text('确认'),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text("等待账号为【love_you】的对象确认")
            ],
          ),
        ));
  }

  void _submitLoveAccount() {
    Fluttertoast.showToast(msg: "请输入你对象的账号");
  }

  Future _getImage() async {
    // _picker是ImagePicker格式，pickedFile 是PickedFile格式
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
    // PickedFile pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    // 图片压缩
    // 文件流
    File file = File(pickedFile.path);
    // 处理luban使用的文件信息对象
    CompressObject compressObject = CompressObject(
        imageFile: file, // image
        path: file.path.substring(0, file.path.lastIndexOf("/")));
    // 压缩
    Luban.compressImage(compressObject).then((_path) async {
      String filename = _path.substring(_path.lastIndexOf("/") + 1);
      try {
        var result = await FileApi.upload(FormData.fromMap(
            {"file": await MultipartFile.fromFile(_path, filename: filename)}));
        if (result.data['success']) {
          var data = result.data["data"];
          String uploadImageUrlPath = data["urlPath"];
          String uuid = data["uuid"];
          setState(() {
            _uploadImageUrlPath = Env.envConfig.appDomain + uploadImageUrlPath;
            _resourcesUuid = uuid;
          });
        } else {
          await showAlertDialog(context, "错误", result.data['message']);
        }
      } catch (e) {
        e.toString();
        await showAlertDialog(context, "错误", "上传失败");
      }
    });
  }
}
