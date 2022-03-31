import 'package:flutter/material.dart';

import '../services/task_service.dart';
import '../ui/helper/color_helper.dart';
import '../ui/helper/text_helper.dart';
import '../ui/helper/icon_helper.dart';

class DetailTaskPage extends StatefulWidget {
  final String? docId;
  final String? title;
  final String? task;
  final String? date;
  final bool? finished;

  const DetailTaskPage(
      {Key? key, this.docId, this.title, this.task, this.date, this.finished})
      : super(key: key);

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  final TaskService _taskService = TaskService(); //Firebase Task Service
  Color containerBgColor = ColorHelper.themeColor;
  Widget? finishedButtonStyle;

  @override
  void initState() {
    finishedButtonStyle =
        finishedButtonStyle1(); //if task status enables finishedButtonStyle1
    super.initState();
  }

  finishedButtonStyle1() => ElevatedButton(
      //status Enabled Button
      style: ElevatedButton.styleFrom(primary: ColorHelper.colorWhite),
      onPressed: widget.finished == true
          ? null
          : () {
              updateTaskFun(widget.docId.toString());
            },
      child: Text(
        TextHelper.taskStatusDisabledBtnText,
        style: TextStyle(
            color: widget.finished == true
                ? ColorHelper.colorWhite
                : ColorHelper.themeColor),
      ));

  finishedButtonStyle2() => ElevatedButton(
      //status disabled Button
      style: ElevatedButton.styleFrom(primary: ColorHelper.colorWhite),
      onPressed: null,
      child: const Text(
        TextHelper.taskStatusDisabledBtnText,
        style: TextStyle(color: ColorHelper.colorWhite),
      ));

  void updateTaskFun(String taskId) {
    //update Task Status
    _taskService.updateTask(taskId);
    setState(() {
      containerBgColor = ColorHelper.themeColor2;
      finishedButtonStyle = finishedButtonStyle2();
    });
  }

  void deleteTaskFun(String taskId) {
    //delete Task
    _taskService.removeTask(taskId);
  }

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
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 20.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    TextHelper.title2,
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    TextHelper.title3,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ColorHelper.colorGreen,
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: widget.finished == false
                                  ? containerBgColor
                                  : ColorHelper.themeColor2,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${widget.title}',
                                      style: const TextStyle(
                                          color: ColorHelper.colorWhite,
                                          fontSize: 25.0),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: IconHelper.taskDocIcon2,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Text(
                                            '${widget.task}',
                                            style: const TextStyle(
                                                color: ColorHelper.colorWhite,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 20.0),
                                  child: Row(
                                    children: [
                                      IconHelper.taskDateIcon,
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          '${widget.date}',
                                          style: const TextStyle(
                                              color: ColorHelper.colorWhite,
                                              fontSize: 15.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary:
                                                      ColorHelper.colorWhite),
                                              onPressed: () {
                                                deleteTaskFun(
                                                    widget.docId.toString());
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                TextHelper.taskDeteleBtnText,
                                                style: TextStyle(
                                                    color:
                                                        ColorHelper.themeColor),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 20.0),
                                            child: finishedButtonStyle),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
