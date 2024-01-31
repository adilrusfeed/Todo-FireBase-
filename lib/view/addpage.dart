// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todofirebase/controller/homeprovider.dart';
import 'package:todofirebase/model/student_model.dart';
import 'package:todofirebase/view/home.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final pro = Provider.of<StudentProvider>(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController rollController = TextEditingController();
    TextEditingController classController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt),
                  label: Text('Camera'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement gallery functionality here
                  },
                  icon: Icon(Icons.photo_library),
                  label: Text('Gallery'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: rollController,
              decoration: InputDecoration(
                labelText: 'Roll No',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: classController,
              decoration: InputDecoration(
                labelText: 'Class',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_validateFields(
                    nameController, rollController, classController)) {
                  addStudent(
                      context, nameController, rollController, classController);
                } else {
                  _showAlert(context, 'Please fill in all fields.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 248, 248, 248),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateFields(
      TextEditingController nameController,
      TextEditingController rollController,
      TextEditingController classController) {
    return nameController.text.isNotEmpty &&
        classController.text.isNotEmpty &&
        rollController.text.isNotEmpty;
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void addStudent(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController rollController,
      TextEditingController classController) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final name = nameController.text;
    final roll = rollController.text;
    final classs = classController.text;

    final student = StudentModel(
      name: name,
      rollno: roll,
      classs: classs,
    );

    provider.addStudent(student);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
