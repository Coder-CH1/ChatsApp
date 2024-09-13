
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileUser {
  final String user_id;
  final DateTime created_at;
  final String phone_number;
  final String display_name;

  ProfileUser({
    required this.user_id,
    required this.created_at,
    required this.phone_number,
    required this.display_name,
});

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      user_id: json['userId'],
      created_at: DateTime.parse(json['createdAt'] as String),
      phone_number: json['phoneNumber'],
      display_name: json['displayName'],
    );
  }
}

Future<ProfileUser?> fetchProfileUser() async {
  final userId = Supabase.instance.client.auth.currentUser?.id;

  if (userId == null) {
    return null;
  }

  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';

  final client = SupabaseClient(supabaseUrl, supabaseKey);
  final response = await client
  .from('profiles')
  .select()
  .eq('id', userId)
  .single();

  final data = response.data;
if (data == null) {
  return null;
}
    return ProfileUser.fromJson(data as Map<String, dynamic>);
}

extension on PostgrestMap {
   get data => null;
}