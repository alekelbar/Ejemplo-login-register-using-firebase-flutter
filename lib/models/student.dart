class Student {
  final String? profesor;
  final String? career;
  final String? course;
  final String? name;

  Student({
    this.profesor,
    this.career,
    this.course,
    this.name,
  });

  Student.fromJson(Map<String, dynamic> json)
      : profesor = json['Profesor'] as String?,
        career = json['career'] as String?,
        course = json['course'] as String?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() =>
      {'Profesor': profesor, 'career': career, 'course': course, 'name': name};
}
