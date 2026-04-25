import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:quiz/Models/education_model.dart';

class EducationController {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://zvgjlkrymuqdwntrsegx.supabase.co',
      anonKey: 'sb_publishable_HDXhoxyemG3Yvs_AD7Dcwg_vjWVTR1R',
    );
  }

  final supabase = Supabase.instance.client;
  List<EducationModel> educationList = [];

  Future<bool> saveEducation(String name, String dept, String university) async {
    try {
      final education = EducationModel(
        studentName: name.trim(),
        dept: dept.trim(),
        university: university.trim(),
      );

      await supabase.from('education').insert(education.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchEducationList() async {
    try {
      final data = await supabase
          .from('education')
          .select()
          .order('id', ascending: false);

      educationList = (data as List)
          .map((json) => EducationModel.fromJson(json))
          .toList();
    } catch (e) {
      educationList = [];
    }
  }
}