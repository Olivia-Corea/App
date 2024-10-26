import 'package:flutter/material.dart';
import 'package:alarm_geni/screen/alarmpage.dart';
import 'package:alarm_geni/alarm_component/alarm_manager.dart';
import 'package:alarm_geni/alarm_component/alarm_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<AlarmInfo> alarms = await loadAlarmData();
  runApp(AlarmGeni(alarms: alarms));
}

class AlarmGeni extends StatelessWidget {
  final List<AlarmInfo> alarms;
  AlarmGeni({Key? key, required this.alarms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlarmGeni',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedIconTheme: IconThemeData(color: Colors.white),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey),
      ),
      home: AlarmPage(),
    );
  }
}
