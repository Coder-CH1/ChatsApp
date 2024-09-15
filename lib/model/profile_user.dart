
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

  Map<String, dynamic> toJson() => <String, dynamic>{
    'userId': user_id,
    'createdAt': created_at,
    'phoneNumber': phone_number,
    'displayName': display_name
  };
}

 Future<ProfileUser?> fetchProfileUser(String userId) async {
//   final Supabase _supabase;
//    final response = await _supabase.client
//        .from('profiles')
//        .select()
//        .eq('id, userId')
//        .single();
//
 }