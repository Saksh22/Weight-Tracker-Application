import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weight_tracker/weights_class.dart';
import 'home.dart';
import 'package:path_provider/path_provider.dart' as Path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await Path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WeightAdapter());
  await Hive.openBox('weights');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
