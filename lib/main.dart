import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'globals.dart' as global;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _getData() async {
    setState(() {
      global.totalCases ='';
      global.totalDeaths ='';
      global.totalRecovered ='';
      global.newCases ='';
      global.newDeaths ='';
      global.statisticTakenAt ='';
    });
    var url = "https://tacticalcodes.000webhostapp.com/covid19api/?task=get_world_statistics";
    var response = await http.get(url);
    if(response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        global.totalCases =jsonResponse["total_cases"];
        global.totalDeaths=jsonResponse["total_deaths"];
        global.totalRecovered=jsonResponse["total_recovered"];
        global.newCases=jsonResponse["new_cases"];
        global.newDeaths=jsonResponse["new_deaths"];
        global.statisticTakenAt=jsonResponse["statistic_taken_at"];
      });
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: Text(
            'Error fetching API response.',
          ),
          backgroundColor: Colors.red
      ));
    }
  }

  @override
  initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: TextFormField(
                controller: TextEditingController()..text = global.totalCases.toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Total Cases',
                ),
                enabled: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextFormField(
                controller: TextEditingController()..text = global.totalDeaths.toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Total Deaths',
                ),
                enabled: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextFormField(
                controller: TextEditingController()..text = global.totalRecovered.toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Total Recovered',
                ),
                enabled: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextFormField(
                controller: TextEditingController()..text = global.newCases.toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Cases',
                ),
                enabled: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextFormField(
                controller: TextEditingController()..text = global.newDeaths.toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Deaths',
                ),
                enabled: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: TextFormField(
                controller: TextEditingController()..text = global.statisticTakenAt.toString(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Statistic Taken At',
                ),
                enabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
