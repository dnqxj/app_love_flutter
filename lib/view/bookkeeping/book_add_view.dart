import 'package:flutter/material.dart';
import 'package:new_app/base/view.dart';
import 'package:new_app/global/Global.dart';
import 'package:new_app/utils/alert_utils.dart';

class BookAddView extends StatefulWidget {
  const BookAddView({Key key}) : super(key: key);

  @override
  _BookAddViewState createState() => _BookAddViewState();
}

class _BookAddViewState extends State<BookAddView> {
  // 申明数据
  TextEditingController _money;
  TextEditingController _desc;
  List<Map> _types = [
    {"name": "收入", "id": 0},
    {"name": "支出", "id": 1},
  ];
  int _type = 0;
  List _modeList = [];
  String _mode = '';

  @override
  void initState() {
    _money = new TextEditingController();
    _desc = new TextEditingController();
    // 加载初始化数据
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    _money.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("新增记账"),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text("类型"),
              trailing: Text(_types[_type]['name'].toString()),// 尾部widget
              onTap: _showTypesAlert,
            ),
            Divider(height: 1,),
            ListTile(
              title: Text("方式"),
              trailing: Text(_mode.toString()),
              onTap: _showModelsAlert,
            ),
            Divider(height: 1,),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入金额",
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: true,
                controller: _money,
              ),
            ),
            Divider(height: 1,),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入备注",
                ),
                textInputAction: TextInputAction.send,
                controller: _desc,
              ),
            ),
            SizedBox(height: 16,),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: RaisedButton(
                onPressed: _submit,
                child: Text("新增"),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 加载初始页面数据，方式的选项数据
  void loadData()async {
    var modelData = await loadModeData(_type);
    setState(() {
      _modeList = modelData;
    });
  }

  void _showTypesAlert() async {
    var result = await showObjectAlertDialog(_types, "选择类型", "name");
    print(result);
    if(result != null && result['id'] != _type) {
      setState(() {
        _type = result["id"];
      });
      //  调用接口拉取方式数据
      var modelData = await loadModeData(result['id']);
      setState(() {
        _mode = "";
        _modeList = modelData;
      });
    }
  }

  loadModeData(int type) async{
    var result = await Global.getInstance().dio.get("/bookkeeping/model_list", queryParameters: {
      "type": type
    });
    if(result.data["status"] == "success") {
      return result.data['data'];
    } else {
      return [];
    }
  }

  void _showModelsAlert() async {
    var result = await showListAlertDialog(_modeList, "选择方式");
    if(result != null) {
      setState(() {
        _mode = result;
      });
    }
  }

  void _submit() async {
    var result = await Global.getInstance().dio.post("/bookkeeping/add_item", data: {
      "type": _type,
      "mode": _mode,
      "money": _money.text,
      "desc": _desc.text
    });

    print(result);
    Navigator.pop(context, 'refresh');
  }


}
