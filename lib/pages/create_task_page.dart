import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  String _selectedDate = DateFormat.yMd().format(DateTime.now());
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
                    'Yeni Görev',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.black87),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Başlık',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: TextFormField(
                controller: taskController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Görev',
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
                child: TextField(
                  controller: dateController,
                  enabled: false,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('İptal')),
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
                                      const Text('Başlık Alanı Boş Geçilemez'),
                                  action: SnackBarAction(
                                      label: 'Anladım', onPressed: () {})),
                            );
                          } else {
                            if (taskController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        const Text('Görev Alanı Boş Geçilemez'),
                                    action: SnackBarAction(
                                        label: 'Anladım', onPressed: () {})),
                              );
                            } else {
                              try {
                                var result = _taskService.addNewTask(
                                    titleController.text,
                                    taskController.text,
                                    _selectedDate.toString(),
                                    false);
                                Navigator.pop(context);
                              } catch (e) {
                                AlertDialog(
                                  title: Text(
                                      'Görev eklenemedi, internet bağlantınızı kontrol ediniz.'),
                                );
                              }
                            }
                          }
                        },
                        child: Text('Görevi Ekle')),
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
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));

    setState(() {
      if (selected != null) {
        _selectedDate = DateFormat.yMd().format(selected).toString();
      } else {
        _selectedDate = DateFormat.yMd().format(DateTime.now()).toString();
      }
    });
  }
}
