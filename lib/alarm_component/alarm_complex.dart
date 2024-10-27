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
  String _selectedTone = 'Default';

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // 필요시 첫 번째 프레임 렌더링 이후 실행할 코드
        setState(() {
          // 상태 업데이트가 필요한 경우
        });
      }
    });
  }

  void onTimeSelected(TimeOfDay newTime) {
    setState(() {
      _selectedTime = newTime;
    });
  }

  void _saveAlarm() {
    final alarmInfo = AlarmInfo(
      time: _selectedTime.format(context),
      isActive: true,
    );
    widget.onAlarmSaved(alarmInfo);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.1),
              _buildTimeSelector(),
              _buildMissionTile(),
              _buildRepeatSwitch(),
              if (_isRepeating) _buildDaysSelector(),
              _buildSoundSelector(),
              _buildVolumeSlider(),
              const SizedBox(height: 20),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: screenWidth * 0.75,
        height: screenHeight / 3, // 크기를 명시적으로 설정
        child: TimeSelector(onTimeSelected: onTimeSelected),
      ),
    );
  }

  Widget _buildMissionTile() {
    return ListTile(
      title: const Text(
        'Mission',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: const Text(
        'Select a mission for this alarm',
        style: TextStyle(color: Colors.white70),
      ),
      trailing: const Icon(Icons.quiz, color: Colors.white),
      onTap: () {
        // 미션 선택 로직 추가
      },
    );
  }

  Widget _buildRepeatSwitch() {
    return SwitchListTile(
      title: const Text(
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
    );
  }

  Widget _buildDaysSelector() {
    return Wrap(
      spacing: 4.0,
      children: List<Widget>.generate(7, (index) {
        return ChoiceChip(
          label: Text(
            ['S', 'M', 'T', 'W', 'T', 'F', 'S'][index],
            style: TextStyle(
              color: _days[index] ? Colors.white : Colors.black,
            ),
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
    );
  }

  Widget _buildSoundSelector() {
    return ListTile(
      title: const Text(
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
            child: Text(value, style: const TextStyle(color: Colors.black)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVolumeSlider() {
    return Slider(
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
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      onPressed: _saveAlarm,
      child: const Text('Save Alarm'),
    );
  }
}
