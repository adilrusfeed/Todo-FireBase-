import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todofirebase/model/student_model.dart';
import 'package:todofirebase/service/service.dart';

class StudentProvider extends ChangeNotifier {
  FirebaseService _firebaseService = FirebaseService();
  String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = '';

  Stream<QuerySnapshot<StudentModel>> getData() {
    return _firebaseService.studentref.snapshots();
  }

  addStudent(StudentModel student) async {
    await _firebaseService.studentref.add(student);
    notifyListeners();
  }

  deleteStudent(id) async {
    await _firebaseService.studentref.doc(id).delete();
    notifyListeners();
  }

  updateStudent(id, StudentModel student) async {
    await _firebaseService.studentref.doc(id).update(student.toJson());
    notifyListeners();
  }
}
