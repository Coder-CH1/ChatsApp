
import 'package:chatsapp/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabaseUrl = dotenv.env['SUPERBASE_URL'];
  final supabaseKey = dotenv.env['SUPERBASE_KEY'];
  final debugMode = dotenv.env['DEBUG'] == 'true';

  if (supabaseUrl == null || supabaseKey == null) {
    print('error, environment variables are not set properly');
    return;
  }

  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const UserRegistration(),
    );
  }
}
