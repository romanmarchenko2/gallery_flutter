import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home.dart';

class FullImageScreen extends StatelessWidget {
  final int index;

  const FullImageScreen({this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Full Size Image",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.w300, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Card(
          margin: EdgeInsets.all(25),
          child: Container(
            color: Colors.white,
            child: GestureDetector(
                child: Hero(
                  tag: "hero-$index",
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Image.network(
                              imgLst[index]['urls']['full'],
                            ),
                          ),
                        )
                      ]),
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
          ),
        ));
  }
}
