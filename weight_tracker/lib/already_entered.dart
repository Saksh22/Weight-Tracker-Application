import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/chart.dart';
import 'package:weight_tracker/history.dart';
import 'package:weight_tracker/weights_class.dart';

class AlreadyEntered extends StatefulWidget {
  final index;
  AlreadyEntered({this.index});

  @override
  _AlreadyEnteredState createState() => _AlreadyEnteredState();
}

class _AlreadyEnteredState extends State<AlreadyEntered> {
  final weightbox = Hive.box('weights');
  String selectedDate;

  String str;

  void getTime() {
    setState(() {
      selectedDate = DateFormat.yMd().add_jm().format(DateTime.now());
    });
  }

  String onlyDate;
  void getDate() {
    setState(() {
      onlyDate = selectedDate.split(' ')[0];
    });
  }

  @override
  void initState() {
    selectedDate = DateFormat.yMd().add_jm().format(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());
    getDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weight = weightbox.getAt(widget.index) as Weight;
    final yestweight = weightbox.getAt(widget.index - 1) as Weight;
    final diff =(weight.weight.roundToDouble() - yestweight.weight.roundToDouble());
    if (diff < 0) {
      setState(() {
        str = 'Lost';
      });
    } else {
      setState(() {
        str = "Gained";
      });
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        centerTitle: true,
        title: Text(
          'Weight Tracker',
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: Colors.redAccent,
                    size: 24.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    selectedDate,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                "Latest Weight",
                style: TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.redAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Date: ${weight.date}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Weight: ${weight.weight} Kg',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    color: Colors.blue,
                    child: Text(
                      'History',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Route route =
                          MaterialPageRoute(builder: (context) => History());
                      Navigator.push(context, route);
                    },
                  ),
                  SizedBox(width: 25),
                  FlatButton(
                    color: Colors.blue,
                    child: Text(
                      'View Stats',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Route route =
                          MaterialPageRoute(builder: (context) => Chart());
                      Navigator.push(context, route);
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Text(
                "Your Progress",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                '$str ${diff.abs().toString()} Kgs',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                "Good Job!!",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
