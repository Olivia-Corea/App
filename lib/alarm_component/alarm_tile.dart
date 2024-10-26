import 'package:flutter/material.dart';
import 'alarm_info.dart';


// 각 알람을 나타내는 위젯
class AlarmTile extends StatelessWidget {
  final AlarmInfo alarmInfo;

  AlarmTile(this.alarmInfo);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54, // 예제 이미지에 맞춰 카드 색상을 설정
      child: ListTile(
        title: Text(
          alarmInfo.time,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Switch(
          value: alarmInfo.isActive,
          onChanged: (value) {
            // TODO: 알람 활성화/비활성화 로직
          },
          activeColor: Colors.blue,
        ),
      ),
    );
  }
}
