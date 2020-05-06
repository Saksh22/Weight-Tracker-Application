import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weight_tracker/home.dart';
import 'package:weight_tracker/weights_class.dart';

class EnterWeight extends StatefulWidget {
  EnterWeight({Key key}) : super(key: key);

  @override
  _EnterWeightState createState() => _EnterWeightState();
}

class _EnterWeightState extends State<EnterWeight> {
  final weightbox = Hive.box('weights');
  double weightToday;
  String selectedDate;
  bool submitted;

  String onlyDate;

  void getTime() {
    setState(() {
      selectedDate = DateFormat.yMd().add_jm().format(DateTime.now());
    });
  }

  void getDate() {
    setState(() {
      onlyDate = selectedDate.split(' ')[0];
    });
  }

  getclass(date, weight, submitted) {
    print(date);
    print(weight);
    print(submitted);
    return Weight(date, weight, submitted);
  }

  @override
  void initState() {
    selectedDate = DateFormat.yMd().add_jm().format(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
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
                SizedBox(height: 60),
                Text(
                  "Current Weight",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                    border: OutlineInputBorder(),
                    hintText: "Enter your weight (in Kg):",
                    hintStyle: TextStyle(fontSize: 19),
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    if (value != null)
                      setState(() {
                        weightToday = double.parse(value);
                      });

                  },
                ),
                SizedBox(height: 15.0),
                FlatButton(
                    onPressed: () {
                      getDate();
                      if (weightToday == null) {
                        Alert(
                                context: context,
                                title: 'Empty Field',
                                desc: 'Enter Your weight please!',
                                buttons: [],
                                style: AlertStyle(backgroundColor: Colors.cyan))
                            .show();
                      } else {
                        Alert(
                            context: context,
                            title: 'Confirm Submit ?',
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Date: $onlyDate'),
                                      Text('weight: $weightToday Kg'),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FlatButton(
                                      color: Colors.black,
                                      child: Text(
                                        'Cancel',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                      color: Colors.black,
                                      child: Text(
                                        'Okay',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          submitted = true;
                                        });
                                        weightbox.add(getclass(onlyDate,
                                            weightToday, submitted));
                                        Route route = MaterialPageRoute(
                                            builder: (context) => Home());
                                        Navigator.pushReplacement(
                                            context, route);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                            buttons: [],
                            style: AlertStyle(
                                backgroundColor: Colors.cyan,
                                titleStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))).show();
                      }
                    },
                    color: Colors.blue,
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
