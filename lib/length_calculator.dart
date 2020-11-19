import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LengthRatioCalc extends StatefulWidget {
  @override
  LengthRatioCalcState createState() => LengthRatioCalcState();
}

class LengthRatioCalcState extends State<LengthRatioCalc> {
  String _acResult = "";
  String _aRemain = "";

  final TextEditingController _runOneTonnage = TextEditingController();
  final TextEditingController _lengthOne = TextEditingController();
  final TextEditingController _lengthTwo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Length Ratio Calculator",
            style: TextStyle(fontSize: 15),
          ),
          backgroundColor: Color.fromRGBO(0, 155, 199, 1),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _runOneTonnage,
                    decoration:
                        InputDecoration(labelText: "Completed Tonnes"))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _lengthOne,
                    decoration:
                        InputDecoration(labelText: "Completed Length (m)"))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _lengthTwo,
                    decoration:
                        InputDecoration(labelText: "Total Length (m)"))),
            Container(
              child: FlatButton(
                  onPressed: _handleCalculation,
                  child: Text("Calculate"),
                  color: Colors.orange[700],
                  textColor: Colors.white,
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 24.0, right: 24.0)),
            ),
            acResultsWidget(_acResult, _aRemain)
          ],
        ))));
  }

  void _handleCalculation() {
    double R = double.tryParse(_runOneTonnage.text) ?? (-1.0);
    double l1 = double.tryParse(_lengthOne.text) ?? (-1.0);
    double l2 = double.tryParse(_lengthTwo.text) ?? (-1.0);
    double result = l2 / l1 * R - R;
    double aRemain = l2 - l1;

    if (R < 0 || l1 < 0 || l2 < 0) {
      _acResult = "Please enter valid positive input in all fields.";
      _aRemain = "";
    } else if ((l2 - l1) > 0) {
      _acResult = result.toStringAsFixed(3) + " tonnes";
      _aRemain = aRemain.toString() + " m";
    } else {
      _acResult = "Total length must be more than completed length.";
      _aRemain = "";
    }

    setState(() {});
  }

  Widget acResultsWidget(acResult, aRemain) {
    if (_acResult == "Please enter valid positive input in all fields.") {
      return Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 30),
          child: Column(children: [
            Text("Please enter valid positive input in all fields.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.red))
          ]));
    } else if (_acResult ==
        "Total length must be more than completed length.") {
      return Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 30),
          child: Container(
              child: Text("Total length must be more than completed length.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.red))));
    } else if (_acResult == "") {
      return Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 30),
          child: Container(
              child: Text("Please enter values to use the calculator",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.black))));
    } else {
      return Container(
          margin: EdgeInsets.only(top: 30.0),
          child: Column(children: [
            Text("Remaining length (m)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 20),
                child: Text(_aRemain, style: TextStyle(fontSize: 15.0))),
            Text("Remaining indicative tonnes",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 20),
                child: Text(_acResult, style: TextStyle(fontSize: 15.0)))
          ]));
    }
  }
}