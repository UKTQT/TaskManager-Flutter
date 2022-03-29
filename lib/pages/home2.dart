import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/task_add_widget.dart';
import 'create_task_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  DateTime dateTimeNow = DateTime.now();
  DateTime endDate = DateTime.utc(2022, 12, 31);

  dateDifference() {
    final int dateDifference = endDate.difference(dateTimeNow).inDays;
    return dateDifference;
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double containerHeight = screenHeight - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
        actions: [
          ElevatedButton(
            onPressed: () {
              _controller.animateToSelection();
            },
            child: Icon(Icons.replay),
          )
        ],
      ),
      body: Container(
        height: containerHeight,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DatePicker(
                DateTime.now(),
                width: 50,
                height: 80,
                locale: 'tr_TR',
                controller: _controller,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                activeDates: List<DateTime>.generate(dateDifference(), (index) {
                  return DateTime.now().add(Duration(days: index));
                }),
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),
            ),
            Text(_selectedValue.toString()),
            SizedBox(height: 200.0),
            //taskAddWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //_showSimpleDialog();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateTaskPage()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Yeni'),
      ),
    );
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  void _showSimpleDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Yeni Görev Ekle'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Başlık',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Görev',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputDatePickerFormField(
                    autofocus: false,
                    fieldLabelText: 'Tarih',
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030)),
              ),
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Close')),
            ],
          );
        });
  }
}
