import 'dart:convert';

import 'package:objectbox/objectbox.dart';

enum LogType { purchase, cashIn, cashTransfer }

@Entity()
class Log {
  int id = 0;
  final String data;
  DateTime time;
  final int logType;

  Log({
    required this.data,
    required this.logType,
    required this.time,
  }) ;

  LogType get logTypeEnum {
    return LogType.values[logType];
  }

  Map<String,dynamic> get dataMap {
    return jsonDecode(data) as Map<String, dynamic>;
  }
}
