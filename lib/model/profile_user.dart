

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileUser {
  final int id;
  final DateTime createdAt;
  final String phoneNumber;
  final String displayName;

  ProfileUser({
    required this.id,
    required this.createdAt,
    required this.phoneNumber,
    required this.displayName,
});

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
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
  //.execute();

  // if (response.error != null) {
  //   throw response.error!;
  // }
  final data = response.data;
if (data == null) {
  return null;
}
    return ProfileUser.fromJson(data as Map<String, dynamic>);
}

extension on PostgrestMap {
   get data => null;
}