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
  late List<AlarmInfo> alarms;

  @override
  void initState() {
    super.initState();
    alarms = widget.alarms; // Initialize the alarms list with the provided data
  }

  void _onAlarmSaved(AlarmInfo newAlarm) {
    setState(() {
      alarms.add(newAlarm); // Add the new alarm to the list
    });
    // Additional alarm saving logic can be added here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: alarms.isEmpty
                ? Center(
              child: Text(
                'No Alarms',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: alarms.length,
              itemBuilder: (context, index) {
                final alarm = alarms[index];
                return ListTile(
                  title: Text(
                    alarm.time,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    alarm.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              },
            ),
          ),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComplexAlarm(onAlarmSaved: _onAlarmSaved),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
