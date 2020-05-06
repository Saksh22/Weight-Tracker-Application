import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/already_entered.dart';
import 'package:weight_tracker/enter_weight.dart';
import 'package:weight_tracker/weights_class.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  final weightbox = Hive.box('weights');

  String selectedDate;
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

  int index;

  getindex() {
    for (int i = 0; i < weightbox.length; i++) {
      final weight = weightbox.getAt(i) as Weight;
      if (weight.date == onlyDate) {
        setState(() {
          index = i;
        });
      }
    }
  }



  @override
  void initState() {
    selectedDate = DateFormat.yMd().add_jm().format(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());
    getTime();
    getDate();
    getindex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (index == null) {
      return EnterWeight();
    } else {
      return AlreadyEntered(index: index);
    }
  }
}
