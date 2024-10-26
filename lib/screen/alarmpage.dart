import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alarm_geni/alarm_component/alarm_manager.dart';
import 'package:alarm_geni/alarm_component/alarm_info.dart';
import 'package:alarm_geni/alarm_component/alarm_complex.dart';
import 'package:alarm_geni/alarm_component/alarm_tile.dart';


class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  bool isMenuOpen = false;
  List<AlarmInfo> alarms = [];

  void _toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }
  void _onSimpleAlarm(){
    // Simple Alarm 설정 동작
  }

  void _onComplexAlarm(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ComplexAlarm(
            onAlarmSaved: (newAlarm){
              setState(() {
                alarms.add(newAlarm); // Add the new alarm to the list and refresh the UI.
              });
              saveAlarmData(alarms); // 수정된 전체 알람 리스트를 SharedPreferences에저장
            }
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadAlarmData();
  }

  Future<void> loadAlarmData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? alarmStringList = prefs.getStringList('alarms_key');
    if (alarmStringList != null) {
      setState(() {
        alarms = alarmStringList.map((alarmString) => AlarmInfo.fromMap(json.decode(alarmString))).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fabSize = screenWidth * 0.15; // 화면 너비의 20%

    return Scaffold(
      body: Padding(
        // 좌, 우로 전체 width의 5%< 상단으로 세로 사이즈의 5% 패딩을 추가함
        padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          top : screenHeight * 0.05,
        ),
        child: Column(
          children: <Widget>[
            Container(
              // 전체 세로 사이즈의 20%를 할애
              height: screenHeight * 0.2,
              color: Colors.blue,
              child: Center(
                child: Text('다음 알림은 ~ 입니다'),
              ),
            ),
            Container(
              //전체 세로사이즈의 10%를 할애
              height: screenHeight * 0.09,
              color: Colors.green,
              child: Center(
                child: Text('여기에 추가 정보'),
              ),
            ),
            Expanded(
              // 나머지 공간은 알람박스들이 차지하도록
              child: ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  return AlarmTile(alarms[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: isMenuOpen,
            child: FloatingActionButton(
              mini: true,
              onPressed: _onSimpleAlarm, // Simple 알람 설정으로 변경
              child: Icon(Icons.alarm), // 아이콘 추가
              backgroundColor: Colors.blue, // 배경색 추가
              heroTag: 'simple',
            ),
          ),
          SizedBox(height: 10), // 버튼 간격을 적절하게 조절
          Visibility(
            visible: isMenuOpen,
            child: FloatingActionButton(
              mini: true,
              onPressed: _onComplexAlarm,
              child: Icon(Icons.add_alarm), // 아이콘 추가
              backgroundColor: Colors.green, // 배경색 추가
              heroTag: 'complex',
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _toggleMenu,
            child: Icon(isMenuOpen ? Icons.close : Icons.add),
            backgroundColor: isMenuOpen ? Colors.red : Colors.red,
            heroTag: 'main',
          ),
        ],
      ),
    );
  }
}
