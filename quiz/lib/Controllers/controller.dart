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

  Future<bool> saveEducation(String name, String route, String age, String vehicle) async {
    try {
      EducationModel education = EducationModel(
        driverName: name.trim(),
        driverRoute: route.trim(),
        driverAge: age.trim(),
        vehicleName: vehicle.trim(),
      );

      await supabase.from('drivers').insert(education.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchEducationList() async {
    try {
      final data = await supabase
          .from('drivers')
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