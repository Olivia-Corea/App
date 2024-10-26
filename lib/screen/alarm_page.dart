import 'package:flutter/material.dart';
import 'package:alarm_geni/alarm_component/alarm_info.dart';
import 'package:alarm_geni/screen/alarm_complex.dart';

class AlarmPage extends StatefulWidget {
  final List<AlarmInfo> alarms;

  AlarmPage({Key? key, required this.alarms}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  List<AlarmInfo> alarms = []; // 알람 목록을 저장할 리스트

  void _onAlarmSaved(AlarmInfo newAlarm) {
    setState(() {
      alarms.add(newAlarm); // 새 알람을 목록에 추가
    });
    // 여기에 알람 저장 로직을 추가할 수 있습니다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Spacer(), // 상단 공간을 유지하려면 이 줄을 추가하세요
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.access_time, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.hourglass_empty, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.school, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.bar_chart, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.sentiment_satisfied, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // 여기에 알람 목록을 표시하는 위젯을 추가할 수 있습니다.
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComplexAlarm()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
