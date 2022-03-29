import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/create_task_model.dart';
import 'package:firebase_core/firebase_core.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addNewTask(String title, String task, String date, bool finished) async {
    var ref = _firestore.collection('task');

    var documentRef = await ref.add({
      'title': title,
      'task': task,
      'date': date,
      'finished': finished,
    });

    return TaskCreate(
        id: documentRef.id,
        title: title,
        task: task,
        date: date,
        finished: finished);
  }
}
