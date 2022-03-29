import 'dart:convert';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  DateTime dateTimeNow = DateTime.now();
  DateTime endDate = DateTime.utc(2022, 12, 31);

  dateDifference() {
    final int dateDifference = endDate.difference(dateTimeNow).inDays;
    return dateDifference;
  }

  late final List<String> trMonthName = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ];
  late final dateItems = List<DateTime>.generate(dateDifference(), (index) {
    DateTime date = dateTimeNow;
    return date.add(Duration(days: index));
  });

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: dateItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print(dateItems[2].month);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double containerHeight = screenHeight - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          dateTimeNow.toString().substring(0, 10).replaceAll('-', ' '),
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: /*[*/
                List<Widget>.generate(dateItems.length, (i) {
              DateTime date = dateTimeNow;
              return Tab(
                  child: Column(children: [
                Text(trMonthName[1]),
                Text(dateItems[i].day.toString()),
              ]));
            }),
          ),
        ),
      ),
      body: Container(
        height: containerHeight,
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: List<Widget>.generate(dateItems.length, (i) {
                    return Center(
                      child: Text('ewq'),
                    );
                  }),

                  /*const <Widget>[
                    Center(
                      child: Text('ewq'),
                    ),
                    Center(
                      child: Text('ewq'),
                    ),
                    Center(
                      child: Text('ewq'),
                    ),
                    Center(
                      child: Text('ewq'),
                    ),
                    Center(
                      child: Text('ewq'),
                    ),
                    Center(
                      child: Text('ewq'),
                    ),
                    Center(
                      child: Text('ewq'),
                    ),
                  ],*/
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Yeni'),
      ),
    );
  }
}
