import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:new_app/eventbus/event_bus.dart';
import 'package:new_app/global/Global.dart';
import 'package:new_app/global/global_theme.dart';
import 'package:new_app/provider/app_provider.dart';
import 'package:new_app/utils/alert_utils.dart';
import 'package:new_app/utils/data_utils.dart';
import 'package:provider/provider.dart';

class DateAlertAdd extends StatefulWidget {
  const DateAlertAdd({Key key}) : super(key: key);

  @override
  _DateAlertAddState createState() => _DateAlertAddState();
}

class _DateAlertAddState extends State<DateAlertAdd> {
  String _messageDay;
  String _birthDay;
  bool _push;
  bool _type;
  TextEditingController _nameController;

  // 分类列表
  List _classifyOptions = [
    {
      "label": "生日",
      "value": 1,
    },
    {
      "label": "认识纪念日",
      "value": 2,
    },
    {
      "label": "恋爱纪念日",
      "value": 3,
    },
    {
      "label": "结婚纪念日",
      "value": 4,
    }
  ];
  Map _classify = null;

  @override
  void initState() {
    _push = false;
    _type = true;
    _nameController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeColor = themes[Provider.of<AppProvider>(context).themeColor];
    return Column(
      children: [
        ListTile(
          leading: Text(
            "姓名",
            style: TextStyle(fontSize: 18),
          ),
          title: Container(
            child: TextField(
              controller: _nameController,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: "请输入姓名"),
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Text(
            "分类",
            style: TextStyle(fontSize: 18),
          ),
          title: Row(children: [
            Text(_classify != null ? _classify['label'].toString() : '请选择分类'),
          ]),
          onTap: _showModelsAlert,
        ),
        Divider(
          height: 1,
        ),
        ListTile(
            leading: Text(
              "日期",
              style: TextStyle(fontSize: 18),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: _birthDay != null ? Text(_birthDay) : Text("请选择日期"),
                  onTap: _showDateAlertTwo,
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: _themeColor,
                        value: _type,
                        onChanged: (v) {
                          setState(() {
                            _type = v;
                          });
                        }),
                    Text(_type ? "阴历" : "阳历"),
                  ],
                )
              ],
            )),
        Divider(
          height: 1,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: RaisedButton.icon(
            onPressed: _submit,
            icon: Icon(Icons.add),
            label: Text("提交"),
          ),
        ),
      ],
    );
  }

  // 选择分类
  void _showModelsAlert() async {
    var result = await showObjectAlertDialog(_classifyOptions, "选择分类", "label");
    if (result != null) {
      setState(() {
        _classify = result;
      });
    }
  }

  void _showDateAlert() {
    DatePicker.showDatePicker(context,
        // 是否展示顶部操作按钮
        showTitleActions: true,
        // 最小时间
        minTime: DateTime(1950, 1, 1),
        // 最大时间
        maxTime: DateTime(2030, 1, 1),
        // change事件
        onChanged: (date) {
      // print('change $date');
    },
        // 确定事件
        onConfirm: (date) {
      print('confirm $date');
      setState(() {
        _messageDay = getYMD(date);
      });
    },
        // 当前时间
        currentTime: DateTime.now(),
        // 语言
        locale: LocaleType.zh);
  }

  void _showDateAlertTwo() {
    DatePicker.showDatePicker(context,
        // 是否展示顶部操作按钮
        showTitleActions: true,
        // 最小时间
        minTime: DateTime(1950, 1, 1),
        // 最大时间
        maxTime: DateTime(2030, 1, 1),
        // change事件
        onChanged: (date) {
      // print('change $date');
    },
        // 确定事件
        onConfirm: (date) {
      print('confirm $date');
      setState(() {
        _birthDay = getYMD(date);
      });
    },
        // 当前时间
        currentTime: DateTime.now(),
        // 语言
        locale: LocaleType.zh);
  }

  // 新增提交
  void _submit() async {
    Map<String, dynamic> params = Map();
    params["uid"] = 1;
    params["name"] = _nameController.text;
    params["type"] = _type ? 1 : 0;
    params["date"] = _birthDay;
    params["messageDay"] = _messageDay;
    print(params);
    try {
      var res =
          await Global.getInstance().dio.post("/love/add_date", data: params);
      if (res.data['status'] == 'success') {
        // 清空
        setState(() {
          _messageDay = null;
          _birthDay = null;
          _push = false;
          _type = true;
          _nameController.clear();
        });
        bus.emit("addDateAfterToList", 0);
      } else {}
    } catch (e) {
      print(e);
    }
  }
}
