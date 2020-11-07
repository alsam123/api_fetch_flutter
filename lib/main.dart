import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeRoute(),
  ));
}

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Color(0xff333333),
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(
                  child: Column(
                children: [
                  Text("Tap here to fetch the data",
                      style: TextStyle(fontSize: 30, color: Color(0xffE0E0E0))),
                  SizedBox(height: 80),
                  FloatingActionButton(
                      backgroundColor: Color(0xffE0E0E0),
                      child: Icon(FontAwesomeIcons.angleRight,
                          color: Color(0xff333333)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondRoute()),
                        );
                      }),
                ],
              )),
            ))));
  }
}

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  bool initial = true, loading, error = false;

  var map = new Map();

  @override
  void initState() {
    loading = true;
    super.initState();

    fetch_data_from_api();
  }

  Future<String> fetch_data_from_api() async {
    var jsondata =
        await http.get("https://jsonplaceholder.typicode.com/todos/1");
    try {
      map = jsonDecode(jsondata.body);
      setState(
        () {
          loading = false;
        },
      );
    } catch (Exception) {
      setState(
        () {
          loading = false;
          error = true;
        },
      );

      print(Exception);
    }

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          
          color: Color(0xff333333),
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xffE0E0E0),
                    strokeWidth: 2,
                  ),
                )
              : loading == false && error == false
                  ? Center(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffE0E0E0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          height: 170,
                          width: 250,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Center(child:Column(children: [
                              Row(children: [
                                Text(
                                  'user ID : ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff333333),
                                  ),
                                ),
                                Text(
                                  map["userId"].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ]),
                              Row(children: [
                                Text(
                                  'ID  : ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff333333),
                                  ),
                                ),
                                Text(
                                  map["id"].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ]),
                              Row(children: [
                                Text(
                                  'title  : ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff333333),
                                  ),
                                ),
                                Text(
                                  map["title"].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ]),
                              Row(children: [
                                Text(
                                  'completed : ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff333333),
                                  ),
                                ),
                                Text(
                                  map["completed"].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ]),
                            ]) ),
                          )),
                    )
                  : Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffE0E0E0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 50,
                        width: 250,
                        child: Center(
                          child: Text(
                            "Error! Failed to load data",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff333333),
                            ),
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
