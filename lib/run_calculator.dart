import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mixTypes.dart';

class RunCalc extends StatefulWidget {
  @override
  RunCalcState createState() => RunCalcState();
}

class RunCalcState extends State<RunCalc> {
  String _acResult = "";
  String _area = "";
  String dropDownValue = mixesList[1];
  String densityValue = densitiesDict[mixesList[1]].toString();

  final TextEditingController _depth = TextEditingController();
  final TextEditingController _length = TextEditingController();
  final TextEditingController _widthOne = TextEditingController();
  final TextEditingController _widthTwo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Run Ratio Calculator",
            style: TextStyle(fontSize: 15),
          ),
          backgroundColor: Color.fromRGBO(0, 155, 199, 1),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column ( children: <Widget> [
            Container(
              child: Column(
              children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10.0),
                    child: Text(
                    "Mix Type: ",
                    style: TextStyle(fontSize: 15),
                  )),
                  Row (
                    children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: DropdownButton<String>(
                      value: dropDownValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      focusColor: Colors.blue[100],
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Color.fromRGBO(246, 130, 28, 1),
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownValue = newValue;
                          _handleCalculation();
                        });
                      },
                      items: mixesList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Text(
                    densityValue + " t/m3",
                    style: TextStyle(fontSize: 15),
                  ),
                ]),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _depth,
                    decoration: InputDecoration(labelText: "Depth (mm)"))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _length,
                    decoration: InputDecoration(labelText: "Site Length (m)"))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _widthOne,
                    decoration: InputDecoration(labelText: "Width One (m)"))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _widthTwo,
                    decoration: InputDecoration(
                        labelText: "Width Two (m) (Optional)"))),
            Container(
              child: FlatButton(
                  onPressed: _handleCalculation,
                  child: Text("Calculate"),
                  color: Colors.orange[700],
                  textColor: Colors.white,
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 24.0, right: 24.0)),
            ),
            acResultsWidget(_acResult, _area)
            ],
        ))])));
  }

  void _handleCalculation() {
    double d = double.tryParse(_depth.text) ?? (-1.0);
    double l = double.tryParse(_length.text) ?? (-1.0);
    double w1 = double.tryParse(_widthOne.text) ?? (-1.0);

    var w;
      if ((_widthTwo.text).isEmpty) {
        w = w1;
      } else {
        double w2 = double.parse(_widthTwo.text);
        w = (w1 + w2) / 2;
      }
  
    double md = densitiesDict[dropDownValue];

    if (d < 0 || w1 < 0 || l < 0 || w < (w1/2)) {
      _acResult = "Please enter valid positive input in all fields.";
      _area = "";
    } else {
      double result = d * l * w * md / 1000;
      _acResult = result.toStringAsFixed(3) + " tonnes";
      _area = (w * l).toInt().toString() + " m2";
    }

    densityValue = md.toString();

    setState(() {});
  }

  Widget acResultsWidget(acResult, area) {

    if (_acResult == "Please enter valid positive input in all fields.") {
      return Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 30),
          child: Column(children: [
            Text("Please enter valid positive input in all fields.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.red))
          ]));
    } else if (_acResult == "") {
      return Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 30),
          child: Container(
              child: Text("Please enter values to use the calculator",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.black))));
    } else {
      return Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Column(children: [
            Text("Indicative Area (m2)",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(_area, style: TextStyle(fontSize: 15.0))),
            Text("Indicative tonnes",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(_acResult, style: TextStyle(fontSize: 15.0)))
          ]));
  }
}}