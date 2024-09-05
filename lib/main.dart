
import 'dart:io';

import 'package:chatsapp/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final envFilePath = '/Users/mac/Documents/ChatsApp/.env';
  final file = File(envFilePath);
  if (await file.exists()) {
    print('File exist: $envFilePath');
  } else {
    print('File does not exist: $envFilePath');
  }
   try {
     await dotenv.load(fileName: envFilePath);
     print('environment variables loaded successfully');
   } catch (e) {
    print('error loading variables $e');
   }
  final supabaseUrl = dotenv.env['SUPERBASE_URL'];
  final supabaseKey = dotenv.env['SUPERBASE_KEY'];
  final debugMode = dotenv.env['DEBUG'] == 'true';
  final contents = await file.readAsString();

  // Print environment variables to debug
  print('SUPABASE_URL: $supabaseUrl');
  print('SUPABASE_KEY: $supabaseKey');
  print('file contents: $contents');
  print('Debug: $debugMode');
  print(dotenv.env);

  if (supabaseUrl == null || supabaseKey == null) {
    print('error, environment variables are not set properly');
    return;
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  runApp(const MyApp());
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
