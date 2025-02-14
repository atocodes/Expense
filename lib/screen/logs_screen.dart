import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/expense_bloc.dart";
import "../bloc/expense_event.dart";
import "../models/log.dart";

class LogsScreen extends StatefulWidget {
  static String routeName = "/logs";
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  late List<Log> logs;

  @override
  void initState() {
    super.initState();
    _updateLogsList();
  }

  void _updateLogsList() {
    logs = context.read<ExpenseBloc>().logs.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("LOGS"),
        centerTitle: true,
        actions: [
          TextButton.icon(
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.clear_all),
            label: const Text("CLEAR ALL"),
            onPressed: () {
              context.read<ExpenseBloc>().add(ClearLogs());
              setState(_updateLogsList);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...logs.map(buildListTile),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(Log log) {
    LogType logType = log.logTypeEnum;
    IconData prefixIcon = Icons.add;
    Color color = Theme.of(context).colorScheme.secondary;
    String suffixTxt = "";
    switch (logType) {
      case LogType.cashIn:
        suffixTxt = log.dataMap['cash'].toString();
        break;
      case LogType.cashTransfer:
        prefixIcon = Icons.currency_exchange;
        color = Colors.yellowAccent;
        suffixTxt = log.dataMap['cash'].toString();
        break;
      case LogType.purchase:
        prefixIcon = Icons.shopping_cart;
        color = Colors.white;
        suffixTxt = log.dataMap['name'].toString();
        break;
    }
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                prefixIcon,
                color: color,
              ),
              Text(
                suffixTxt,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .merge(TextStyle(color: color)),
              ),
            ],
          ),
          Text(
            "Date : ${log.time.toString()}",
            overflow: TextOverflow.visible,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .merge(const TextStyle(fontSize: 10)),
          )
        ],
      ),
      subtitle: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: subTitleWidgets(log.dataMap),
          ),
          Divider(color: Theme.of(context).colorScheme.onPrimary),
        ],
      ),
    );
  }

  List<Widget> subTitleWidgets(Map<String, dynamic> data) =>
      data.entries.map((MapEntry<String, dynamic> entry) {
        return Text(
            "${entry.key.replaceFirst(entry.key[0], entry.key[0].toUpperCase())} : ${entry.value.toString()} \t");
      }).toList();
}
