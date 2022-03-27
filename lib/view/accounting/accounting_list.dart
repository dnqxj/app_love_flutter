import 'package:flutter/material.dart';
import 'package:new_app/base/view.dart';
import 'package:new_app/global/Global.dart';
import 'package:weui/toast/index.dart';


class AccountingView extends StatefulWidget {
  const AccountingView({Key key}) : super(key: key);

  @override
  _AccountingViewState createState() => _AccountingViewState();
}

class _AccountingViewState extends State<AccountingView> {
  var _data;
  var _monthData;
  int _month;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("记账"),
        centerTitle: true,
        elevation: 10, // 阴影
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text(DateTime.now().year.toString() + "年", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),)),
                    Expanded(child: Text("预算", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),)),
                    Expanded(child: Text("收入", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),)),
                    Expanded(child: Text("支出", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),)),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          child: Text(_month.toString() + "月", style: TextStyle(color: Colors.white, fontSize: 16,),),
                          onTap: _getMonth,
                        )
                    ),
                    Expanded(child: Text(_monthData["budget"].toString(), style: TextStyle(color: Colors.white, fontSize: 16,),)),
                    Expanded(child: Text(_monthData["income"].toString(), style: TextStyle(color: Colors.white, fontSize: 16,),)),
                    Expanded(child: Text(_monthData["expenditure"].toString(), style: TextStyle(color: Colors.white, fontSize: 16,),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: true, // 根据子组件的高度
          itemBuilder: _itemBuilder,
          itemCount: _data == null ? 0 : _data.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _add,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var itemData = _data[index];
    var dayData = itemData["dayData"];
    var children = itemData["children"];
    // return Text(_data[index]["name"].toString());
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(dayData['date'], style: Theme.of(context).textTheme.title,),
              ),
              Text("收入：" + dayData['income'].toString(), style: Theme.of(context).textTheme.bodyText1,),
              SizedBox(width: 8,),
              Text("支出：" + dayData["expenditure"].toString(), style: Theme.of(context).textTheme.bodyText1),
          ],
          ),
        ),
        Divider(height: 1,),
        Column(
          children: _childrens(children),
        ),
      ],
    );
  }

  List<Widget> _childrens(var datas) {
    List<Widget> widgets = [];
    for (var i = 0; i < datas.length; i ++ ) {
      var itemData = datas[i];
      widgets.add(Container(height: 8,));
      widgets.add(Row(
        children: [
          Icon(Icons.add),
          SizedBox(width: 16,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemData['action'] == 0 ? '收入' : '支出'),
                Text("描述：" + itemData['desc'], style: TextStyle(
                  color: Colors.grey,
                ),),
              ],
            )
          ),
          Text(itemData['money'].toString())
        ],
      ));
      // 仿佛是在外面嵌套
      widgets.add(Container(height: 10,));
    }
    return widgets;
  }
  
  void loadData() async{
    if(_month == null) {
      _month = DateTime.now().month;
    }
    setState(() {
      _data = [];
    });
    var result = await Global.getInstance().dio.get("/bookkeeping/item", queryParameters: {
      "date": DateTime.now().year.toString() + (_month < 10 ? "0" + _month.toString() : _month),
      "month": _month
    });
    print(result);
    if (result.data["status"] == "success") {
      var data = result.data["data"];
      var list = data["list"];
      var monthData = data["monthData"];
      setState(() {
        _data = list;
        _monthData = monthData;
      });
    } else {
      WeToast.fail(context)(message: result.data["message"]);
    }
  }

  void _getMonth() {
    List list = [];
    for (var i = 1; i <= 12; i++) {
      if(i < DateTime.now().month) {
        list.add(i);
      } else {
        break;
      }
    }
    showDialog(context: context, builder: (BuildContext context) {
      return SimpleDialog(
          children: list.map((e) {
            return SimpleDialogOption(
              child: Text(e.toString() + "月"),
              onPressed: () {
                _month = e; // 给全局data赋值，重新获取
                Navigator.pop(context); // 关闭弹窗
                loadData();
              },
            );
          }).toList(),
      );
    }, barrierDismissible: false,);
  }

  void _add()async {
    var result = await Navigator.of(context).pushNamed("accounting/add");
    if(result != null && result == 'refresh') {
      loadData();
    }
  }
}
