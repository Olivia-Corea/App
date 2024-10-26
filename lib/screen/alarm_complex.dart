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
  // ... 기존 상태 변수들 ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Set Alarm'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                if (_isRepeating)
                  Wrap(
                    children: List<Widget>.generate(7, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ChoiceChip(
                          label: Text(
                            ['S', 'M', 'T', 'W', 'T', 'F', 'S'][index],
                            style: TextStyle(
                                color:
                                    _days[index] ? Colors.white : Colors.black),
                          ),
                          selected: _days[index],
                          onSelected: (bool selected) {
                            setState(() {
                              _days[index] = selected;
                            });
                          },
                          backgroundColor: Colors.white,
                          selectedColor: Colors.blue,
                        ),
                      );
                    }),
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
                        child:
                            Text(value, style: TextStyle(color: Colors.black)),
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
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                  onPressed: _saveAlarm,
                  child: Text('Save Alarm'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ... 기존 메서드들 ...
}
