import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../widgets/task_add_widget.dart';
import 'create_task_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(_selectedValue.toString()),
            ),
            GestureDetector(
              onTap: () {
                tikla();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 20.0),
                child: Container(
                  color: Colors.deepPurple,
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: const [
                        SlidableAction(
                          onPressed: sil,
                          backgroundColor: Color(0xFFff281d),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Görevi Sil',
                        ),
                      ],
                    ),
                    endActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: okundu,
                          backgroundColor: Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Yapıldı Olarak İşaretle',
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const ListTile(
                        leading: Icon(
                          Icons.note,
                          color: Colors.white,
                          size: 28.0,
                        ),
                        title: Text(
                          'Slide me',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir.',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        trailing: Icon(
                          Icons.history_toggle_off,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                tikla();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 20.0),
                child: Container(
                  color: Color(0xff455a64),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: const [
                        SlidableAction(
                          onPressed: sil,
                          backgroundColor: Color(0xFFff281d),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Görevi Sil',
                        ),
                      ],
                    ),
                    endActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: okundu,
                          backgroundColor: Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Yapıldı Olarak İşaretle',
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const ListTile(
                        leading: Icon(
                          Icons.note,
                          color: Colors.white,
                          size: 28.0,
                        ),
                        title: Text(
                          'Slide me',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir.',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        trailing: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
        icon: const Icon(Icons.add),
        label: const Text('Yeni'),
      ),
    );
  }
}

void sil(BuildContext context) {
  print('silindi');
}

void okundu(BuildContext context) {
  print('okundu');
}

tikla() {
  print('tikla');
}
