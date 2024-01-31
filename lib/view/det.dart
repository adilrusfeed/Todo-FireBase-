// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todofirebase/model/student_model.dart';

class DetailScreen extends StatelessWidget {
  final StudentModel student;

  const DetailScreen({required this.student, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          student.name ?? 'Student Detail',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple, // Set app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.name ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              leading: Icon(
                Icons.person,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                "RollNo",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.rollno ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: Icon(
                Icons.format_list_numbered,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                "Class",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.classs ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: Icon(
                Icons.school,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
