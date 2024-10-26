import 'package:flutter/material.dart';
import 'package:alarm_geni/alarm_component/alarm_info.dart';
import 'package:alarm_geni/widget/numberpicker.dart';

class ComplexAlarm extends StatefulWidget {
  final Function(AlarmInfo) onAlarmSaved;

  const ComplexAlarm({
    Key? key,
    required this.onAlarmSaved,
  }) : super(key: key);

  @override
  _ComplexAlarmState createState() => _ComplexAlarmState();
}

class _ComplexAlarmState extends State<ComplexAlarm> {
  late TimeOfDay _selectedTime;
  bool _isRepeating = false;
  List<bool> _days = List.generate(7, (index) => false);
  double _volume = 0.5;
  String _selectedTone= 'Default';
  // 기타 필요한 상태 변수를 여기에 정의합니다.


  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  void onTimeSelected(TimeOfDay newTime) {
    setState(() {
      _selectedTime = newTime; // 사용자가 새로운 시간을 선택하면 상태를 업데이트
    });
    // 필요하다면 여기서 다른 처리를 추가...
  }

  void _saveAlarm() {
    // Assuming you have a form to enter description and other details
    final alarmInfo = AlarmInfo(
      time: _selectedTime.format(context),
      isActive: true,
    );

    // Call the callback function to pass the alarm info back to the alarm page.
    widget.onAlarmSaved(alarmInfo);

    // Close the dialog
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height : screenHeight * 0.1),
                TimeSelector(onTimeSelected: onTimeSelected),
                ListTile(
                  title: Text(
                    'Mission',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Select a mission for this alarm',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Icon(Icons.quiz, color: Colors.white),
                  onTap: () {
                    // 여기에 미션 선택 로직 추가
                  },
                ),
                SwitchListTile(
                  title: Text(
                    'Repeat',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: _isRepeating,
                  onChanged: (bool value) {
                    setState(() {
                      _isRepeating = value;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                // Only show this if the 'Repeat' switch is on
                if (_isRepeating)
                  Wrap(
                    children: List<Widget>.generate(7, (index) {
                      return ChoiceChip(
                        label: Text(
                          ['S', 'M', 'T', 'W', 'T', 'F', 'S'][index],
                          style: TextStyle(color: _days[index] ? Colors.white : Colors.black),
                        ),
                        selected: _days[index],
                        onSelected: (bool selected) {
                          setState(() {
                            _days[index] = selected;
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: Colors.blue,
                      );
                    }),
                    spacing: 4.0,
                  ),
                ListTile(
                  title: Text(
                    'Sound',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: DropdownButton<String>(
                    value: _selectedTone,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTone = newValue!;
                      });
                    },
                    items: <String>['Default', 'Beep', 'Nostalgia']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  ),
                ),
                Slider(
                  value: _volume,
                  onChanged: (value) {
                    setState(() {
                      _volume = value;
                    });
                  },
                  divisions: 10,
                  label: "${(_volume * 100).round()}%",
                  activeColor: Colors.blue,
                  inactiveColor: Colors.white30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background (button) color
                    onPrimary: Colors.white, // foreground (text) color
                  ),
                  onPressed: _saveAlarm,
                  child: Text('Save Alarm'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
