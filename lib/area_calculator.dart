import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mixTypes.dart';

class AreaRatioCalc extends StatefulWidget {
  @override
  AreaRatioCalcState createState() => AreaRatioCalcState();
}

class AreaRatioCalcState extends State<AreaRatioCalc> {
  String _acResult = "";
  String _aRemain = "";
  String _sRate = "";
  String dropDownValue = mixesList[1];
  String densityValue = densitiesDict[mixesList[1]].toString();

  final TextEditingController _runOneTonnage = TextEditingController();
  final TextEditingController _areaOne = TextEditingController();
  final TextEditingController _areaTwo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Area Ratio Calculator",
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
                    controller: _areaOne,
                    decoration:
                        InputDecoration(labelText: "Completed Area (m2)"))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _areaTwo,
                    decoration: InputDecoration(labelText: "Total Area (m2)"))),
            Container(
              child: FlatButton(
                  onPressed: _handleCalculation,
                  child: Text("Calculate"),
                  color: Colors.orange[700],
                  textColor: Colors.white,
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 24.0, right: 24.0)),
            ),
            acResultsWidget(_acResult, _aRemain, _sRate)
          ],
        ))])));
  }

  void _handleCalculation() {
    double R = double.tryParse(_runOneTonnage.text) ?? (-1.0);
    double a1 = double.tryParse(_areaOne.text) ?? (-1.0);
    double a2 = double.tryParse(_areaTwo.text) ?? (-1.0);
    double result = a2 / a1 * R - R;
    double aRemain = a2 - a1;

    double d = densitiesDict[dropDownValue];

    if (R < 0 || a1 < 0 || a2 < 0) {
      _acResult = "Please enter valid positive input in all fields.";
      _aRemain = "";
    } else if ((a2 - a1) > 0) {
      _acResult = result.toStringAsFixed(3) + " tonnes";
      _aRemain = aRemain.toString() + " m";
      _sRate = (R * 1000 / (a1 * d)).toStringAsFixed(0);
    } else {
      _acResult = "Total area must be more than completed area.";
      _aRemain = "";
    }

    densityValue = d.toString();

    setState(() {});
  }

  Widget acResultsWidget(acResult, aRemain, _sRate) {
    if (_acResult == "Please enter valid positive input in all fields.") {
      return Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 30),
          child: Column(children: [
            Text("Please enter valid positive input in all fields.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.red))
          ]));
    } else if (_acResult == "Total area must be more than completed area.") {
      return Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 30),
          child: Container(
              child: Text("Total area must be more than completed area.",
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
          margin: EdgeInsets.only(top: 10.0),
          child: Column(children: [
            Text("Completed spread rate (mm)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(_sRate, style: TextStyle(fontSize: 15.0))),
            Text("Remaining area (m2)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(_aRemain, style: TextStyle(fontSize: 15.0))),
            Text("Remaining indicative tonnes",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(_acResult, style: TextStyle(fontSize: 15.0)))
          ]));
    }
  }
}