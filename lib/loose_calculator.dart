import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LevelCalc extends StatefulWidget {
  @override
  LevelCalcState createState() => LevelCalcState();
}

class LevelCalcState extends State<LevelCalc> {
  String _acResult = "";

  final TextEditingController _looseFactor = TextEditingController();
  final TextEditingController _inputLevel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Loose Factor Calculator",
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
                    controller: _looseFactor,
                    decoration:
                        InputDecoration(labelText: "Loose Factor (%)"))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    onChanged: (text) {
                      _handleCalculation();
                    },
                    keyboardType: TextInputType.number,
                    controller: _inputLevel,
                    decoration:
                        InputDecoration(labelText: "Compacted Level (mm)"))),
            acResultsWidget(_acResult)
          ],
        ))));
  }

  void _handleCalculation() {
    double R = int.parse(_looseFactor.text) / 100;
    int L = int.tryParse(_inputLevel.text) ?? (0);
    int result = (L + L * R).toInt();
    _acResult = result.toString() + " mm";

    setState(() {});
  }

  Widget acResultsWidget(acResult) {
    return Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(children: [
          Text("Loose Level (mm)",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
          Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 20),
              child: Text(_acResult, style: TextStyle(fontSize: 15.0)))
        ]));
  }
}