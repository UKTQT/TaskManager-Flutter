import 'package:cloud_firestore/cloud_firestore.dart';

class TaskCreate {
  String? id;
  String? title;
  String? task;
  String? date;
  bool? finished;

  TaskCreate({this.id, this.title, this.task, this.date, this.finished});

  factory TaskCreate.fromSnapshot(DocumentSnapshot snapshot) {
    return TaskCreate(
      id: snapshot.id,
      title: snapshot['title'],
      task: snapshot['task'],
      date: snapshot['date'],
      finished: snapshot['finished'],
    );
  }
}
