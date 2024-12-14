import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_exam_todo/controller/home_screen_controller.dart';
import 'package:main_exam_todo/new%20task/new_task.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> _coursesStream =
      FirebaseFirestore.instance.collection('task').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewTask(

                  ),
                ));
          },
        ),
        appBar: AppBar(
          title: Text("Manage your time well"),
          backgroundColor: Colors.blue.shade300,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: _coursesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                    
                      return InkWell(
                        onLongPress: () {
                          context.read<HomeScreenController>().deleteTask(document.id);
                        },
                        child: ListTile(
                          title: Text(data["title"]),
                          trailing: Checkbox(
                            value: data["status"],
                            onChanged: (value) {
                              context.read<HomeScreenController>().isComplete(document.id, value!, data["title"]);
                            },
                          ),
                        
                        ),
                      );
                    })
                    .toList()
                    .cast(),
              );
            },
          ),
        ));
  }
}
