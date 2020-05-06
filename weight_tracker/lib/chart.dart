import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:hive/hive.dart';
import 'package:weight_tracker/weights_class.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chart extends StatefulWidget {

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final weightbox = Hive.box('weights');
  List<double> weights=[];
  List<double> weekly=[];
  List<double> monthly=[];

  getweights(){
    for(int i=0;i<weightbox.length;i++){
      final weight = weightbox.getAt(i) as Weight;
      weights.add(weight.weight);
    }
  }

  getWeekly(){
    for(int i=0;i<weightbox.length;i+=7){
      final weight = weightbox.getAt(i) as Weight;
      weekly.add(weight.weight);
    }
  }

  getMonthly(){
    for(int i=0;i<weightbox.length;i+=30){
      final weight = weightbox.getAt(i) as Weight;
      monthly.add(weight.weight);
    }
  }

  
  

  @override
  void initState() {
    getweights();
    getWeekly();
    getMonthly();
    print(weights);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          centerTitle: true,
          title: Text(
            'Graph',
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.redAccent,
            tabs: <Widget>[
              Tab(icon: Icon(FontAwesomeIcons.calendarDay),),
              Tab(icon: Icon(FontAwesomeIcons.calendarWeek)),
              Tab(icon: Icon(FontAwesomeIcons.calendarCheck)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Daily Progress',style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic,color: Colors.white),),
                      Expanded(
                        child: Sparkline(
                          data: weights,
                          lineColor: Colors.blue,
                          pointsMode: PointsMode.all,
                          pointSize: 15.0,
                          pointColor: Colors.red,
                          sharpCorners: true,
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Weekly Progress',style: TextStyle(fontSize: 24.0,fontStyle: FontStyle.italic,color: Colors.white),),
                      Expanded(
                        child: Sparkline(
                          data: weekly,
                          lineColor: Colors.blue,
                          pointsMode: PointsMode.all,
                          pointSize: 15.0,
                          pointColor: Colors.red,
                          sharpCorners: true,
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Monthly Progress',style: TextStyle(fontSize: 24.0,fontStyle: FontStyle.italic,color: Colors.white),),
                      Expanded(
                        child: Sparkline(
                          data: monthly,
                          lineColor: Colors.blue,
                          pointsMode: PointsMode.all,
                          pointSize: 15.0,
                          pointColor: Colors.red,
                          sharpCorners: true,
                        ),
                      )

                    ],
                  ),
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}