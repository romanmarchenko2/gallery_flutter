import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ListOfImages extends StatefulWidget {
  @override
  _ListOfImages createState() => _ListOfImages();
}

List imgLst;

class _ListOfImages extends State<ListOfImages> {
  get index => index;

  @override
  void initState() {
    super.initState();
    this.fetchListOfImages();
  }

  Future<String> fetchListOfImages() async {
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
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: _gradientBackground(),
            child: Column(children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "Gallery",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: imgLst == null ? 0 : imgLst.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.blue[50],
                        margin: EdgeInsets.all(25),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: Container(
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
                                  Icon(
                                    Icons.account_circle,
                                    color: Colors.black,
                                    size: 40.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    imgLst[index]['user']['name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Hero(
                                tag: "hero-$index",
                                child: GestureDetector(
                                    child: Image.network(
                                      imgLst[index]['urls']['thumb'],
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                    ),
                                    onTap: () => _openDetail(context, index)),
                              ),
                              ListTile(
                                title: Text(
                                  imgLst[index]['description'] == null
                                      ? 'No Description'
                                      : imgLst[index]['description'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
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

class FullImageScreen extends StatelessWidget {
  final int index;

  const FullImageScreen({this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Full Size Image",
              style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
              textAlign: TextAlign.center),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: _gradientBackground(),
          ),
        ),
        body: Container(
          decoration: _gradientBackground(),
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
        ));
  }
}

BoxDecoration _gradientBackground() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          colors: [Colors.blue, Colors.pink]));
}
