import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  AuthProvider() {
    _user = Supabase.instance.client.auth.currentUser;
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      //_user = data.toString();
      notifyListeners();
    });
  }

  Future<void> signIn(String phoneNumber) async {
    await Supabase.instance.client.auth.signInWithOtp(phone: phoneNumber);
  }

  Future<void> verifyOtp(String token, String displayName) async {
    final response = await Supabase.instance.client.auth.verifyOTP(
        phone: _user!.phone,
        token: token,
        type: OtpType.sms
    );

    if (response.session != null) {
      await Supabase.instance.client.from('profiles').upsert({
        'user_id': response.user?.id,
        'display_name': displayName,
      });
    }
  }

}