class AlarmInfo {
  String time;
  bool isActive;

  AlarmInfo({required this.time, this.isActive = false});

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'isActive': isActive,
    };
  }

  factory AlarmInfo.fromMap(Map<String, dynamic> map) {
    return AlarmInfo(
      time: map['time'],
      isActive: map['isActive'] ?? false,
    );
  }
}
