import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreenController with ChangeNotifier {
  bool isLoading = false;
   var databseCollection = FirebaseFirestore.instance.collection("task");
  Future<void> addTask(
 {required String title,
  bool status = false}
  ) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = {"title": title,"status" :status};
      await databseCollection.add(data);
    } catch (e) {
      print(e);
    }
    isLoading=false;
    notifyListeners();
 
  }

  Future<void> isComplete(var id,bool value,String title) async {
final updatedStatus = {
  "title" :title,
  "status": value
};
await databseCollection.doc(id).set(updatedStatus);
  }


  Future<void> deleteTask(var id) async {
    await databseCollection.doc(id).delete();
  }
}