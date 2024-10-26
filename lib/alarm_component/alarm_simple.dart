import 'package:flutter/material.dart';
import 'package:alarm_geni/alarm_component/alarm_info.dart';

// _addAlarm 함수 정의. 이제 context, alarms 리스트, 그리고 setState 함수를 매개변수로 받습니다.
Future<void> addAlarm(
  BuildContext context,
  List<AlarmInfo> alarms,
  Function setState,
) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime != null) {
    setState(() {
      alarms.add(AlarmInfo(
        time: pickedTime.format(context),
        description: "New Alarm at ${pickedTime.format(context)}",
        isActive: true,
      ));
    });
  }
}
