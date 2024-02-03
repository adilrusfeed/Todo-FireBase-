// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todofirebase/controller/homeprovider.dart';
import 'package:todofirebase/controller/imageprovider.dart';
import 'package:todofirebase/model/student_model.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  StudentModel student;
  String id;
  EditPage({required this.student, required this.id, Key? key})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController classController = TextEditingController();
  File? selectedImage;
  bool clicked = true;

  ImagePicker imagePicker = ImagePicker();

  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    rollController = TextEditingController(text: widget.student.rollno);
    classController = TextEditingController(text: widget.student.classs);
    Provider.of<ImagesProvider>(context, listen: false).selectImage =
        File(widget.student.image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<ImagesProvider>(
          builder: (context, value, child) => Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: rollController,
                decoration: const InputDecoration(labelText: 'RollNo'),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: classController,
                decoration: const InputDecoration(labelText: 'Class'),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      value.setImage(ImageSource.camera);
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
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implement gallery functionality here
                      value.setImage(ImageSource.gallery);
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
              if (value.selectImage != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      value.selectImage!.path,
                    ),
                  ),
                ),
              SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    editData(context, value.selectImage!.path);
                  },
                  child: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  editData(BuildContext context, String imageurl) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final imagepro = Provider.of<ImagesProvider>(context, listen: false);

    try {
      final newName = nameController.text;
      final newRollno = rollController.text;
      final newClass = classController.text;

      await provider.updateImage(imageurl, imagepro.selectImage);

      final updatedStudent = StudentModel(
          image: imageurl, name: newName, rollno: newRollno, classs: newClass);

      provider.updateStudent(widget.id, updatedStudent);
      Navigator.pop(context);
    } catch (e) {
      print("Error on Updating :$e");
    }
  }
}
