import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseController {

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://gadufowkkxuauujdiqml.supabase.co',
      anonKey: 'sb_publishable_eet8sey0Xf-UCDR8TkdqRQ_pG9GuLP2',
    );
  }

  final supabase = Supabase.instance.client;

  Future<void> fetchUsers() async {
    final data = await supabase.from('users').select();
    print(data);
  }

  Future<void> saveData() async {
    await supabase.from('users').insert({
      "name": "Abd",
      "age": 22,
    });
  }
}