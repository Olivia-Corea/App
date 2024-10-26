import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:alarm_geni/alarm_component/alarm_info.dart';

Future<void> saveAlarmData(List<AlarmInfo> alarms) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> alarmStringList = alarms.map((alarm) => json.encode(alarm.toMap())).toList();
  await prefs.setStringList('alarms_key', alarmStringList);
}

Future<List<AlarmInfo>> loadAlarmData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? alarmStringList = prefs.getStringList('alarms_key');
  if (alarmStringList != null) {
    return alarmStringList.map((alarmString) => AlarmInfo.fromMap(json.decode(alarmString))).toList();
  }
  return [];
}

