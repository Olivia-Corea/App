import 'package:flutter/material.dart';

class AlarmDialog extends StatefulWidget {
  final TimeOfDay selectedTime;
  final bool isRepeating;
  final List<bool> days;
  final String selectedTone;
  final double volume;
  final Function(TimeOfDay) onTimeChanged;
  final Function(bool) onRepeatChanged;
  final Function(List<bool>) onDaysChanged;
  final Function(String) onToneChanged;
  final Function(double) onVolumeChanged;
  final Function onSave;

  const AlarmDialog({
    Key? key,
    required this.selectedTime,
    required this.isRepeating,
    required this.days,
    required this.selectedTone,
    required this.volume,
    required this.onTimeChanged,
    required this.onRepeatChanged,
    required this.onDaysChanged,
    required this.onToneChanged,
    required this.onVolumeChanged,
    required this.onSave,
  }) : super(key: key);

  @override
  _AlarmDialogState createState() => _AlarmDialogState();
}

class _AlarmDialogState extends State<AlarmDialog> {
  late TimeOfDay _selectedTime;
  late bool _isRepeating;
  late List<bool> _days;
  late String _selectedTone;
  late double _volume;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.selectedTime;
    _isRepeating = widget.isRepeating;
    _days = List.from(widget.days);
    _selectedTone = widget.selectedTone;
    _volume = widget.volume;
  }

  void _presentTimePicker() {
    // 여기에 시간 선택 로직 구현
  }

  void _saveAlarm() {
    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    // Dialog 구성 코드
  }
}
