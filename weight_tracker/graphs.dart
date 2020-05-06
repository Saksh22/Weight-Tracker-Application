import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'weights_class.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final weightbox = Hive.box('weights');

  List<Weight> data1=[];


  List<charts.Series<dynamic,num>> seriesGraphData=[];

  generateData(){
 
    for(int i=0;i<weightbox.length;i++){
      final weight=weightbox.getAt(i) as Weight;
      data1.add(weight);
    }  

     seriesGraphData.add(
      charts.Series(
        id: "Daily",
        data: data1,
        domainFn: (dynamic weight,_) =>weight.date,
        measureFn: (dynamic weight,_) =>weight.weight,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (dynamic weight, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
    
      ),
    );

  }


  @override
  void initState() {
    super.initState();
    generateData();
    seriesGraphData=List<charts.Series<dynamic,num>>();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text("Statistics"),
      ),
      body: SingleChildScrollView(
              child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: charts.LineChart(
              seriesGraphData,
                defaultRenderer: new charts.LineRendererConfig(includeArea: true, stacked: true),
              animate: true,
              animationDuration: Duration(seconds: 5),
                behaviors: [
                  new charts.ChartTitle('Days',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                  new charts.ChartTitle('Progress',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                ]
            ),
          ),
        ),
      ),


    );
  }
}

