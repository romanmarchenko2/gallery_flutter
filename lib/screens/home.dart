import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gallery/services/auth.dart';
import 'package:http/http.dart' as http;

import 'fullSize.dart';

List imgLst;

class FetchImages extends StatefulWidget {
  @override
  _FetchImages createState() => _FetchImages();
}

class _FetchImages extends State<FetchImages> {
  get index => index;
  @override
  void initState() {
    super.initState();
    this.fetchFetchImages();
  }

  Future<String> fetchFetchImages() async {
    String _apiKey =
        ('https://api.unsplash.com/search/photos?per_page=100&client_id=CzQraAoh0CTpcwKVLAiNtojqB1SiG4jSkjZPnl0mnuw&query=all');
    try {
      final response = await http.get(_apiKey);
      setState(() {
        var data = json.decode(response.body);
        imgLst = data['results'];
      });
    } catch (e) {
      throw Exception('Failed to load images');
    }
    return "List Of Images";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          title: Text(
            "Gallery",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.w300, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  AuthService().logOut();
                },
                icon: Icon(
                  Icons.supervised_user_circle,
                  color: Colors.white,
                ),
                label: SizedBox.shrink())
          ],
        ),
        body: Container(
            color: Colors.grey[100],
            child: Column(children: <Widget>[
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: imgLst == null ? 0 : imgLst.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(25),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        child: Container(
                          height: 495,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: new BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.blueGrey),
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: new NetworkImage(
                                                  imgLst[index]['user']
                                                          ['profile_image']
                                                      ['small'])))),
                                  Expanded(
                                    flex: 3,
                                    child: ListTile(
                                      title: Text(
                                          imgLst[index]['user']['username'] ==
                                                  null
                                              ? ' '
                                              : imgLst[index]['user']
                                                  ['username'],
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      subtitle: Text(
                                          imgLst[index]['user']['location'] ==
                                                  null
                                              ? ' '
                                              : imgLst[index]['user']
                                                      ['location']
                                                  .toString()
                                                  .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.grey[400],
                                      size: 33,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 3),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  )))),
                              Hero(
                                tag: "hero-$index",
                                child: GestureDetector(
                                    child: Image.network(
                                      imgLst[index]['urls']['thumb'],
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      width: 240,
                                    ),
                                    onTap: () => _openDetail(context, index)),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 3),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  )))),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      imgLst[index]['likes'].toString() == null
                                          ? '0 likes'
                                          : imgLst[index]['likes'].toString() +
                                              ' likes',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ])));
  }

  _openDetail(context, index) {
    final route = MaterialPageRoute(
      builder: (context) => FullImageScreen(index: index),
    );
    Navigator.push(context, route);
  }
}
