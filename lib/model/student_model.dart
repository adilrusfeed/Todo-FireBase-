class StudentModel {
  String? name;
  String? rollno;
  String? classs;

  StudentModel({this.name, this.rollno, this.classs});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['Name'] as String?,
      rollno: json['RollNo'] as String?,
      classs: json['Class'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'rollno': rollno, 'class': classs};
  }
}
