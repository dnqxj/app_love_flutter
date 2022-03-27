import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_app/eventbus/event_bus.dart';
import 'package:new_app/global/Global.dart';
import 'package:new_app/utils/data_utils.dart';

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
    return Column(
      children: [
        ListTile(
          leading: Text("妹妹姓名", style: TextStyle(fontSize: 18),),
          title: Container(
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入妹妹姓名"
              ),
            ),
          ),
        ),
        Divider(height: 1,),
        ListTile(
          leading: Text("出生日期", style: TextStyle(fontSize: 18),),
          title: GestureDetector(
            child: _birthDay != null ? Text(_birthDay) : Text("请选择日期"),
            onTap: _showDateAlertTwo,
          ),
        ),
        Divider(height: 1,),
        ListTile(
          leading: Text("提醒日期", style: TextStyle(fontSize: 18),),
          title: GestureDetector(
            child: _messageDay != null ? Text(_messageDay) : Text("请选择日期"),
            onTap: _showDateAlert,
          ),
        ),
        Divider(height: 1,),
        Row(
          children: [
            Checkbox(value: _push, onChanged: (v) {
              setState(() {
                _push = v;
              });
            }),
            Text("是否开启推送"),
            SizedBox(width: 32,),
            Checkbox(value: _type, onChanged: (v) {
              setState(() {
                _type = v;
              });
            }),
            Text(_type ? "阴历" : "阳历"),
          ],
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: RaisedButton.icon(
            onPressed: _submit,
            icon: Icon(Icons.add), label: Text("提交"),
          ),
        ),
      ],
    );
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
      var res = await Global.getInstance().dio.post("/love/add_date", data: params);
      if(res.data['status'] == 'success') {
        // 清空
        setState(() {
          _messageDay = null;
          _birthDay = null;
          _push = false;
          _type = true;
          _nameController.clear();
        });
        bus.emit("addDateAfterToList", 0);
      } else {

      }
    } catch (e) {
      print(e);
    }

  }
}
