// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todofirebase/controller/homeprovider.dart';
import 'package:todofirebase/controller/imageprovider.dart';
import 'package:todofirebase/model/student_model.dart';
import 'package:todofirebase/view/home.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController classController = TextEditingController();

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    final imagepro = Provider.of<ImagesProvider>(context);
    // final pro = Provider.of<StudentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      imagepro.setImage(ImageSource.camera);
                    },
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
                      imagepro.setImage(ImageSource.gallery);
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
                controller: widget.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: widget.rollController,
                decoration: InputDecoration(
                  labelText: 'Roll No',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: widget.classController,
                decoration: InputDecoration(
                  labelText: 'Class',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              if (imagepro.selectImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      imagepro.selectImage!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_validateFields()) {
                    addStudent(context);
                  } else {
                    _showAlert(context, 'Please fill in all fields and Image.');
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
      ),
    );
  }

  bool _validateFields() {
    return widget.nameController.text.isNotEmpty &&
        widget.classController.text.isNotEmpty &&
        widget.rollController.text.isNotEmpty;
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
  ) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final imagepro = Provider.of<ImagesProvider>(context, listen: false);
    final name = widget.nameController.text;
    final roll = widget.rollController.text;
    final classs = widget.classController.text;

    await provider.imageAdder(File(imagepro.selectImage!.path));
    final student = StudentModel(
        name: name, rollno: roll, classs: classs, image: provider.downloadurl);

    provider.addStudent(student);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
