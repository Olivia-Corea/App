import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final Function(int) onChanged;
  final int initialValue;

  NumberPicker({
    Key? key,
    this.minValue = 0,
    required this.maxValue,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  late int selectedValue;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    _scrollController =
        FixedExtentScrollController(initialItem: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final itemHeight = screenHeight / 9;

    return Container(
      height: itemHeight * 3,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: itemHeight,
        useMagnifier: true, // 중앙 항을 돋보기처럼 확대
        magnification: 1.5, // 확대 배율
        diameterRatio: 1.2,
        perspective: 0.002,
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          int value = widget.minValue +
              (index % (widget.maxValue - widget.minValue + 1));
          widget.onChanged(value);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Center(
              child: Text(
                  '${widget.minValue + index % (widget.maxValue - widget.minValue + 1)}'),
            );
          },
          childCount: null, // Loop indefinitely
        ),
      ),
    );
  }
}

class TimeSelector extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;

  TimeSelector({required this.onTimeSelected});

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  int selectedHour;
  int selectedMinute;
  bool isPM = false;
  late FixedExtentScrollController _hourScrollController;
  late FixedExtentScrollController _minuteScrollController;

  _TimeSelectorState()
      : selectedHour = TimeOfDay.now().hour,
        selectedMinute = TimeOfDay.now().minute;

  void _onHourChanged(int newHour) {
    setState(() {
      selectedHour = newHour % 12;
      selectedHour = selectedHour == 0 ? 12 : selectedHour;
      if (selectedHour == 12) {
        isPM = !isPM;
      }
      _updateTime();
    });
    print(
        "Hour updated to $selectedHour, isPM: $isPM"); // Add this line for debugging
  }

  void _onMinuteChanged(int newValue) {
    setState(() {
      if (selectedMinute == 59 && newValue == 0) {
        selectedHour = (selectedHour % 12) + 1;
        if (selectedHour == 12) {
          isPM = !isPM;
        }
      } else if (selectedMinute == 0 && newValue == 59) {
        selectedHour = (selectedHour == 1) ? 12 : selectedHour - 1;
        if (selectedHour == 11) {
          isPM = !isPM;
        }
      }
      selectedMinute = newValue;
      _updateTime();
    });
    print("Minute updated to $selectedMinute"); // Add this line for debugging
  }

  void _updateTime() {
    widget
        .onTimeSelected(TimeOfDay(hour: selectedHour, minute: selectedMinute));
  }

  @override
  void initState() {
    super.initState();
    final now = TimeOfDay.now();
    selectedHour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    selectedMinute = now.minute;
    isPM = now.hour >= 12;

    _hourScrollController =
        FixedExtentScrollController(initialItem: selectedHour - 1);
    _minuteScrollController =
        FixedExtentScrollController(initialItem: selectedMinute);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // AM/PM selector
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isPM = false;
                      });
                      print("AM selected"); // Add this line for debugging
                    },
                    child: Text(
                      "오전",
                      style: TextStyle(
                        color: !isPM ? Colors.white : Colors.grey,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isPM = true;
                      });
                      print("PM selected"); // Add this line for debugging
                    },
                    child: Text(
                      "오후",
                      style: TextStyle(
                        color: isPM ? Colors.white : Colors.grey,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24), // Push PM text up slightly
            ],
          ),
          SizedBox(width: screenWidth * 0.05),
          // Time picker and ":" separator
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: NumberPicker(
                    initialValue: selectedHour,
                    minValue: 1,
                    maxValue: 12,
                    onChanged: (value) {
                      _onHourChanged(value);
                      print(
                          "Hour changed to $value"); // Add this line for debugging
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    ":",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                Expanded(
                  child: NumberPicker(
                    initialValue: selectedMinute,
                    minValue: 0,
                    maxValue: 59,
                    onChanged: (value) {
                      _onMinuteChanged(value);
                      print(
                          "Minute changed to $value"); // Add this line for debugging
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ComplexAlarm extends StatefulWidget {
  final Function(TimeOfDay) onAlarmSaved;

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
  }

  void onTimeSelected(TimeOfDay newTime) {
    setState(() {
      _selectedTime = newTime;
    });
  }

  void _saveAlarm() {
    widget.onAlarmSaved(_selectedTime);
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
                SizedBox(height: screenHeight * 0.1),
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
                    // 미션 선택 로직
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
                      return ChoiceChip(
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
}
