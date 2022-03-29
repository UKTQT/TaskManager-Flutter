import 'package:flutter/material.dart';

class TaskAddWidget extends StatelessWidget {
  const TaskAddWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Yeni Görev Ekle'),
      children: <Widget>[
        Row(
          children: const [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Başlık',
              ),
            ),
          ],
        ),
        Row(),
        Row(),
        Row(),
        Row(),
      ],
    );
  }
}
