import 'package:flutter/material.dart';
import 'package:alarm_geni/alarm_component/alarm_info.dart';
import 'package:alarm_geni/screen/alarmpage.dart'; // Make sure this import exists

class MenuPage extends StatelessWidget {
  final List<AlarmInfo> alarms;

  MenuPage({Key? key, required this.alarms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AlarmGeni')),
      body: ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          // Build your alarm list items here
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AlarmPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
