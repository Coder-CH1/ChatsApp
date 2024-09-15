import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileUser {
  final String id;
  final DateTime created_at;
  final String phone_number;
  final String display_name;

  ProfileUser({
    required this.id,
    required this.created_at,
    required this.phone_number,
    required this.display_name,
});

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      id: json['id'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      phone_number: json['phone_number'] as String,
      display_name: json['display_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'created_at': created_at,
    'phone_number': phone_number,
    'display_name': display_name
  };
}

 Future<ProfileUser?> fetchProfileUser(String userId) async {
   final response = await Supabase.instance.client
       .from('profiles')
       .select()
       .eq('id', userId)
       .single();

   final profileUser = ProfileUser.fromJson(response as Map<String, dynamic>);
   return profileUser;
 }