class EducationModel {
  final int? id;
  final String studentName;
  final String dept;
  final String university;

  EducationModel({
    this.id,
    required this.studentName,
    required this.dept,
    required this.university,
  });

  // Convert model to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'student_name': studentName,
      'dept': dept,
      'university': university,
    };
  }

  // Create model from JSON (optional, for fetching data)
  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'],
      studentName: json['student_name'] ?? '',
      dept: json['dept'] ?? '',
      university: json['university'] ?? '',
    );
  }
}