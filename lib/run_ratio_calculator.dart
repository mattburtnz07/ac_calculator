import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mixTypes.dart';

class RunRatioCalc extends StatefulWidget {
  @override
  RunRatioCalcState createState() => RunRatioCalcState();
}

class RunRatioCalcState extends State<RunRatioCalc> {
  String _acResult = "";
  String _sRate = "";
  String dropDownValue = mixesList[1];
  String densityValue = densitiesDict[mixesList[1]].toString();

  final TextEditingController _runOneTonnage = TextEditingController();
  final TextEditingController _widthOne = TextEditingController();
  final TextEditingController _widthTwo = TextEditingController();
  final TextEditingController _runLength = TextEditingController();

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
                  ),]
              ),
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
                    controller: _widthOne,
                    decoration:
                        InputDecoration(labelText: "Completed Width One (m)"))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _widthTwo,
                    decoration:
                        InputDecoration(labelText: "Remaining Width Two (m)"))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _runLength,
                    decoration:
                        InputDecoration(labelText: "Total Site Length (m) (Optional)"))),
            Container(
              child: FlatButton(
                  onPressed: _handleCalculation,
                  child: Text("Calculate"),
                  color: Colors.orange[700],
                  textColor: Colors.white,
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 24.0, right: 24.0)),
            ),
            acResultsWidget(_acResult, _sRate)
          ],
        ))])));
  }

  void _handleCalculation() {
    double R = double.tryParse(_runOneTonnage.text) ?? (-1.0);
    double w1 = double.tryParse(_widthOne.text) ?? (-1.0);
    double w2 = double.tryParse(_widthTwo.text) ?? (-1.0);
    double l = double.tryParse(_runLength.text) ?? (-1.0);

    double d = densitiesDict[dropDownValue];

    if (R < 0 || w1 < 0 || w2 < 0) {
      _acResult = "Please enter valid positive input in all fields.";
      _sRate = "";
    } else if (l < 0) {
      double result = w2 / w1 * R;
      _acResult = result.toStringAsFixed(3) + " tonnes";
      _sRate = "No Length.";
    } else {
      double result = w2 / w1 * R;
      var thickness = (R / (l * w2 / w1 * d)) * 100;
      _acResult = result.toStringAsFixed(3) + " tonnes";
      _sRate = thickness.toInt().toString() + ' mm';
    }

    densityValue = d.toString();

    setState(() {});
  }

  Widget acResultsWidget(acResult, sRate) {
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
    } else if (_sRate == "No Length.") {
      return Column(children: [
        Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10),
            child: Text("Remaining indicative tonnes",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
        Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10),
            child: Text(_acResult, style: TextStyle(fontSize: 15.0)))
      ]);
    } else {
      return Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Column(children: [
            Text("Completed spread rate (mm)",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(_sRate, style: TextStyle(fontSize: 15.0))),
            Text("Remaining indicative tonnes",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(_acResult, style: TextStyle(fontSize: 15.0)))
          ]));
    }
  }
}