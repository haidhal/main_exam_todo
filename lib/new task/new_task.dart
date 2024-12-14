// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:main_exam_todo/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  
  TextEditingController titlecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titlecontroller,
              decoration: InputDecoration(hintText: "title"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                context
                    .read<HomeScreenController>()
                    .addTask(title: titlecontroller.text);
              
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(
                  "SUBMIT",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
