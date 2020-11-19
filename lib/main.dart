import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'run_ratio_calculator.dart';
import 'length_calculator.dart';
import 'area_calculator.dart';
import 'loose_calculator.dart';
import 'run_calculator.dart';

void main() => runApp(MaterialApp(
    title: 'AC Calc',
    theme: ThemeData(
      primaryColor: Colors.blueAccent,
      accentColor: Colors.redAccent,
    ),
    home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromRGBO(0, 155, 199, 1),
            title: Text(
              'Fulton Hogan AC Calculators',
              style: TextStyle(fontSize: 15),
            )),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 70.0, right: 70.0),
              child: Image.asset('assets/fh_logo.png')),
          Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Text(
                'Choose a Calculator...',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20),
              )),
          Container(
              child: Container(
            child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: FlatButton(
                    child: Text('Run Ratio'),
                    color: Color.fromRGBO(246, 130, 28, 1),
                    textColor: Colors.white,
                    padding: EdgeInsets.only(left: 103.0, right: 103.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RunRatioCalc()),
                      );
                    },
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: FlatButton(
                    child: Text('Length Ratio'),
                    color: Color.fromRGBO(246, 130, 28, 1),
                    textColor: Colors.white,
                    padding: EdgeInsets.only(left: 93.0, right: 93.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LengthRatioCalc()),
                      );
                    },
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                  child: FlatButton(
                    child: Text('Area Ratio'),
                    color: Color.fromRGBO(246, 130, 28, 1),
                    textColor: Colors.white,
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 100.0, right: 100.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AreaRatioCalc()),
                      );
                    },
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                    child: Text('Loose Compaction Level'),
                    color: Color.fromRGBO(246, 130, 28, 1),
                    textColor: Colors.white,
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 56.0, right: 56.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LevelCalc()),
                      );
                    },
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10),
                  child: FlatButton(
                    child: Text('Run Calculator'),
                    color: Color.fromRGBO(246, 130, 28, 1),
                    textColor: Colors.white,
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 88.0, right: 88.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RunCalc()),
                      );
                    },
                  )),
            ]),
          ))
        ])));
  }
}