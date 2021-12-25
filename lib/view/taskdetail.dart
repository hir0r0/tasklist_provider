import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/task.dart';

class TaskDetail extends StatelessWidget {
  TaskDetail({Key? key}) : super(key: key);

  final TextEditingController _limitEditController = TextEditingController();
  final TextEditingController _taskNameEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Task? task = ModalRoute.of(context)!.settings.arguments as Task;
    _limitEditController.text = task.limitDate;
    _taskNameEditController.text = task.taskName;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          // child: ListView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  const Text('タスク編集', style: TextStyle(fontSize: 20)),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "yyyy/mm/dd",
                      labelText: '期限',
                    ),
                    controller: _limitEditController,
                    onTap: () => _selectDate(context),
                    readOnly: true,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        hintText: "やること", labelText: 'やること'),
                    maxLength: 20,
                    controller: _taskNameEditController,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                    },
                  ),
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () => {
                      if (_limitEditController.text != '' &&
                          _taskNameEditController.text != '')
                        {
                          Navigator.of(context).pop(
                            Task(task.id, _taskNameEditController.text,
                                _limitEditController.text),
                          ),
                        }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _limitEditController.text == ''
          ? DateTime.now()
          : DateFormat('yyyy/MM/dd').parse(_limitEditController.text),
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
    );

    if (selected != null) {
      String _limitText = selected.year.toString() +
          "/" +
          zeroPadding(selected.month.toString()) +
          "/" +
          zeroPadding(selected.day.toString());
      _limitEditController.text = _limitText;
    }
  }

  String zeroPadding(String str) {
    return str.length == 1 ? "0" + str : str;
  }
}
