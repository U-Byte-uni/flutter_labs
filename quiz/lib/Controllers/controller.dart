import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:quiz/Models/model.dart';

class DriverController {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://zvgjlkrymuqdwntrsegx.supabase.co',
      anonKey: 'sb_publishable_HDXhoxyemG3Yvs_AD7Dcwg_vjWVTR1R',
    );
  }

  final supabase = Supabase.instance.client;
  List<DriverModel> driverList = [];

  Future<bool> saveDriver(String name, String route, String age, String vehicle) async {
    try {
      DriverModel driver = DriverModel(
        driverName: name.trim(),
        driverRoute: route.trim(),
        driverAge: int.parse(age.trim()),    // Convert String to int
        vehicleName: vehicle.trim(),
      );

      await supabase.from('drivers').insert(driver.toJson());
      return true;
    } catch (e) {
      print('Save error: $e');
      return false;
    }
  }

  Future<void> fetchDriverList() async {
    try {
      final response = await supabase
          .from('drivers')
          .select()
          .order('id', ascending: false);

      driverList = (response as List)
          .map((json) => DriverModel.fromJson(json))
          .toList();

      print('Fetched ${driverList.length} drivers');
    } catch (e) {
      print('Fetch error: $e');
      driverList = [];
    }
  }
}