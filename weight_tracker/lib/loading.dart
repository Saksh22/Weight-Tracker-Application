import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldCount() async {}

  @override
  void initState() {
    super.initState();
    setupWorldCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      body: Center(
        child: SpinKitHourGlass(
          color: Colors.white70,
          size: 80.0,
        ),
      ),
    );
  }
}
