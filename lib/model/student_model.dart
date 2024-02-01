class StudentModel {
  String? name;
  String? rollno;
  String? classs;

  String? image;

  StudentModel({this.name, this.rollno, this.classs, required this.image});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      image: json['image'],
      name: json['name'] as String?,
      rollno: json['rollno'] as String?,
      classs: json['class'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'rollno': rollno,
      'class': classs,
    };
  }
}
