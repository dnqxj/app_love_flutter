import 'package:flutter/material.dart';
import 'package:new_app/base/view.dart';
import 'package:new_app/global/Global.dart';
import 'package:new_app/utils/alert_utils.dart';
import 'package:new_app/apis/options/index.dart' as OptionsApi;
import 'package:new_app/apis/bookeep/index.dart' as BookeepApi;

class BookAddView extends StatefulWidget {
  const BookAddView({Key key}) : super(key: key);

  @override
  _BookAddViewState createState() => _BookAddViewState();
}

class _BookAddViewState extends State<BookAddView> {
  // 声明数据
  TextEditingController _money;
  TextEditingController _desc;

  // 类型列表
  List _bookeepTypeOptions = [];
  Map _bookeepType = null;

  // 分类列表
  List _classifyOptions = [];
  Map _classify = null;

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
              trailing: Text(
                  _bookeepType != null ? _bookeepType['label'].toString() : ''),
              // 尾部widget
              onTap: _showTypesAlert,
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              title: Text("分类"),
              trailing:
                  Text(_classify != null ? _classify['label'].toString() : ''),
              onTap: _showModelsAlert,
            ),
            Divider(
              height: 1,
            ),
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
            Divider(
              height: 1,
            ),
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
            SizedBox(
              height: 16,
            ),
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
  void loadData() async {
    var result = await OptionsApi.bookeepType();
    print(result);
    if (result.data["success"]) {
      var data = result.data["data"];
      List list = data["list"];
      setState(() {
        _bookeepTypeOptions = list;
        _bookeepType = list[0];
      });
      //  调用接口拉取分类数据
      await loadClassifyOptions(list[0]["value"]);
    } else {
      await showAlertDialog(context, "错误", result.data['message']);
    }
  }

  void _showTypesAlert() async {
    var result =
        await showObjectAlertDialog(_bookeepTypeOptions, "选择类型", "label");
    print(result);
    if (result != null && result != _bookeepType) {
      setState(() {
        _bookeepType = result;
      });
      //  调用接口拉取分类数据
      await loadClassifyOptions(result['value']);
    }
  }

  // 拉取类型下的分类列表
  loadClassifyOptions(String type) async {
    var params = {"type": type};
    var res = await OptionsApi.classify(params);
    if (res.data["success"]) {
      var data = res.data["data"];
      List list = data["list"];
      setState(() {
        _classifyOptions = list;
        _classify = list[0];
      });
    } else {
      await showAlertDialog(context, "错误", res.data['message']);
    }
  }

  // 选择分类
  void _showModelsAlert() async {
    var result = await showObjectAlertDialog(_classifyOptions, "选择分类", "value");
    if (result != null) {
      setState(() {
        _classify = result;
      });
    }
  }

  void _submit() async {
    if (_bookeepType == null || _bookeepType["value"].isEmpty) {
      await showAlertDialog(context, "错误", "请选择类型~");
      return;
    }
    if (_classify == null || _classify["value"].isEmpty) {
      await showAlertDialog(context, "错误", "请选择分类~");
      return;
    }
    if (_money == null || _money.text.isEmpty) {
      await showAlertDialog(context, "错误", "请输入金额~");
      return;
    }
    if (_classify == null || _classify["value"].isEmpty) {
      await showAlertDialog(context, "错误", "请输入备注~");
      return;
    }
    DateTime dateTime = DateTime.now();
    var params = {
      "year": dateTime.year,
      "month": dateTime.month,
      "day": dateTime.day,
      "total": _money.text,
      "type": _bookeepType["value"],
      "classify": _classify["value"],
      "details": _desc.text
    };
    var result = await BookeepApi.add(params);
    print(result);
    Navigator.pop(context, 'refresh');
  }
}
