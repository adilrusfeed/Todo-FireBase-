class StudentModel {
  String? name;
  String? rollno;
  String? classs;

  StudentModel({this.name, this.rollno, this.classs});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'] as String?,
      rollno: json['rollno'] as String?,
      classs: json['class'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'rollno': rollno, 'class': classs};
  }
}
