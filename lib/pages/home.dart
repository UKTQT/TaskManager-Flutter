import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:localization/localization.dart';

import '../services/task_service.dart';
import 'create_task_page.dart';
import 'detail_task_page.dart';
import '../ui/helper/color_helper.dart';
import '../ui/helper/text_helper.dart';
import '../ui/helper/icon_helper.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', 'TR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('tr', 'TR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatePickerController _controller =
      DatePickerController(); // Date Picker Controller
  final TaskService _taskService = TaskService(); //Firebase Task Service

  @override
  void initState() {
    initializeDateFormatting();

    super.initState();
  }

  var _titleDateValue = DateFormat.yMMMEd('tr_TR').format(DateTime.now());

  dateDifference() {
    //Remaining days in the year
    DateTime dateTimeNow = DateTime.now();
    DateTime endDate = DateTime.utc(2022, 12, 31);

    final int dateDifference = endDate.difference(dateTimeNow).inDays;
    return dateDifference;
  }

  String _newSelectedValue = DateTime.now() //non-nullable
      .toString()
      .substring(0, 10)
      .replaceAll('-', '/')
      .split('/')
      .reversed
      .join('/'); // format 02/04/2022

  void changeTaskDay(String _newSelectedValue, DateTime date) {
    setState(() {
      _newSelectedValue = _newSelectedValue;
      _titleDateValue =
          DateFormat.yMMMEd('tr_TR').format(date); //31 Mar 2022 Per TR Format
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double containerHeight = screenHeight - appBarHeight;

    void deleteTaskFun(BuildContext context, String taskId) {
      _taskService.removeTask(taskId);
    }

    void updateTaskFun(BuildContext context, String taskId) {
      _taskService.updateTask(taskId);
    }

    void goToDetailTaskPage(String docId, String? title, String? task,
        String? date, bool? finished) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailTaskPage(
                    docId: docId,
                    title: title,
                    task: task,
                    date: date,
                    finished: finished,
                  )));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextHelper.title),
        actions: [
          ElevatedButton(
            onPressed: () {
              _controller.animateToSelection();
            },
            child: IconHelper.appBarReplay,
          )
        ],
      ),
      body: Container(
        height: containerHeight,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DatePicker(
                  DateTime.utc(2022, 03, 30),
                  width: 50,
                  height: 80,
                  locale: 'tr_TR',
                  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: ColorHelper.colorBlack,
                  selectedTextColor: ColorHelper.colorWhite,
                  activeDates:
                      List<DateTime>.generate(dateDifference(), (index) {
                    return DateTime.now().add(Duration(days: index - 1));
                  }),
                  onDateChange: (date) {
                    setState(() {
                      _newSelectedValue = date
                          .toString()
                          .substring(0, 10)
                          .replaceAll('-', '/')
                          .split('/')
                          .reversed
                          .join('/'); // format 02/04/2022

                      changeTaskDay(_newSelectedValue, date);
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      _titleDateValue,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 19.0),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: StreamBuilder<QuerySnapshot>(
                  stream: _taskService.getTask(_newSelectedValue),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const CircularProgressIndicator()
                        : snapshot.data!.docs.length != 0
                            ? ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot task =
                                      snapshot.data!.docs[index];

                                  return GestureDetector(
                                    onTap: () {
                                      goToDetailTaskPage(
                                        task.id,
                                        task['title'],
                                        task['task'],
                                        task['date'],
                                        task['finished'],
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0,
                                          right: 16.0,
                                          bottom: 20.0),
                                      child: Container(
                                        color: task['finished'] == false
                                            ? ColorHelper.themeColor
                                            : ColorHelper.themeColor2,
                                        child: Slidable(
                                          key: const ValueKey(0),
                                          startActionPane: ActionPane(
                                            motion: const StretchMotion(),
                                            /*dismissible: DismissiblePane(
                                                onDismissed: () {
                                              deleteTaskFun(context, task.id);
                                            }),*/
                                            children: [
                                              SlidableAction(
                                                flex: 2,
                                                onPressed:
                                                    (BuildContext context) {
                                                  deleteTaskFun(
                                                      context, task.id);
                                                },
                                                backgroundColor:
                                                    ColorHelper.colorRed,
                                                foregroundColor:
                                                    ColorHelper.colorWhite,
                                                icon: Icons.delete,
                                                label: TextHelper
                                                    .actionPanelDeleteText,
                                              ),
                                            ],
                                          ),
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                // An action can be bigger than the others.
                                                flex: 2,
                                                onPressed:
                                                    (BuildContext context) {
                                                  updateTaskFun(
                                                      context, task.id);
                                                },
                                                backgroundColor:
                                                    ColorHelper.colorGreen,
                                                foregroundColor:
                                                    ColorHelper.colorWhite,
                                                icon: Icons.archive,
                                                label: TextHelper
                                                    .actionPanelUpdateText,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              leading: IconHelper.taskDocIcon,
                                              title: Text(
                                                task['title'],
                                                style: const TextStyle(
                                                    color:
                                                        ColorHelper.colorWhite,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Column(
                                                children: [
                                                  Text(
                                                    task['task'],
                                                    style: const TextStyle(
                                                      color: ColorHelper
                                                          .colorWhite2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailing:
                                                  task['finished'] == false
                                                      ? IconHelper.taskFalse
                                                      : IconHelper.taskEnabled,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                child: Center(
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.assignment,
                                        color: Colors.deepPurple,
                                        size: 200.0,
                                      ),
                                      Text(
                                        'Bugün Hiç Görev Yok',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Colors.deepPurple),
                                      )
                                    ],
                                  ),
                                ),
                              );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //_showSimpleDialog();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateTaskPage()));
        },
        icon: IconHelper.newTaskBtn,
        label: const Text(TextHelper.newTaskButtonText),
      ),
    );
  }
}
