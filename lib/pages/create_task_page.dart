import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/task_service.dart';
import '../ui/helper/color_helper.dart';
import '../ui/helper/text_helper.dart';
import '../ui/helper/icon_helper.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TaskService _taskService = TaskService();

  final titleController = TextEditingController();
  final taskController = TextEditingController();
  final dateController = TextEditingController();

  String _selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final String _startDate = DateFormat('hh:mm a').format(DateTime.now());
  final String _endDate =
      DateFormat('hh:mm a').format(DateTime.now().add(Duration(minutes: 15)));

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double containerHeight = screenHeight - appBarHeight;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: containerHeight,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    TextHelper.title4,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: ColorHelper.colorBlack),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: TextFormField(
                controller: titleController,
                obscureText: false,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorHelper.themeColor, width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.themeColor, width: 5.0)),
                  labelText: TextHelper.inputTitleText,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: TextFormField(
                controller: taskController,
                obscureText: false,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorHelper.themeColor, width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.themeColor, width: 5.0)),
                  labelText: TextHelper.inputTaskText,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: InkWell(
                onTap: () {
                  _selectedDatee(context);
                },
                child: TextFormField(
                  controller: dateController,
                  enabled: false,
                  decoration: InputDecoration(
                    suffixIcon: IconHelper.taskDateIcon2,
                    disabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorHelper.themeColor, width: 3.0),
                    ),
                    labelText: '${_selectedDate.toString()}',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ColorHelper.colorRed),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(TextHelper.taskCancelBtnText)),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (titleController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      const Text(TextHelper.inputTitleNullText),
                                  action: SnackBarAction(
                                      label: TextHelper.inputNullUnderstandText,
                                      onPressed: () {})),
                            );
                          } else {
                            if (taskController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: const Text(
                                        TextHelper.inputTaskNullText),
                                    action: SnackBarAction(
                                        label:
                                            TextHelper.inputNullUnderstandText,
                                        onPressed: () {})),
                              );
                            } else {
                              try {
                                var result = _taskService.addNewTask(
                                    titleController.text,
                                    taskController.text,
                                    _selectedDate
                                        .toString()
                                        .replaceAll('-', '/'),
                                    false);
                                Navigator.pop(context);
                              } catch (e) {
                                const AlertDialog(
                                  title: Text(
                                      TextHelper.internetConnectionErrorText),
                                );
                              }
                            }
                          }
                        },
                        child: const Text(TextHelper.taskAddBtnText)),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectedDatee(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        locale: const Locale('tr', 'TR'),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));

    setState(() {
      if (selected != null) {
        _selectedDate = DateFormat('dd-MM-yyyy').format(selected).toString();
      } else {
        _selectedDate =
            DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
      }
    });
  }
}
