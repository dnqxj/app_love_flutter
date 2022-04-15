import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TextDemo extends StatefulWidget {
  const TextDemo({Key key}) : super(key: key);

  @override
  _TextDemoState createState() => _TextDemoState();
}

class _TextDemoState extends State<TextDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Column(
        children: [
          Container(
            height: 300,
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "http://via.placeholder.com/350x350",
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                "记账",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("accounting");
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                "相册",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("love");
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
                child: Text(
                  "日期提醒",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("dateAlert");
                }),
          )
        ],
      ),
    );
  }
}


