import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipbook/core/router/app_router.dart';
import 'package:recipbook/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Импорт AppRouter
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipbook/feature/auth/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Инициализация Supabase
  await Supabase.initialize(
    url: 'https://btkisrsozilabmvyruys.supabase.co', //  Supabase URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0a2lzcnNvemlsYWJtdnlydXlzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5NzY3NTAsImV4cCI6MjA1MjU1Mjc1MH0.n-llE0OD5WT5T35CDkSHOnf3hRAjex8zyuFrLG8c3V4', // Ваш Supabase anon key
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(), // Подключаем AuthCubit
      child: MaterialApp.router(
        title: 'Recipe Book',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.goRouter, // Подключаем GoRouter
      ),
    );
  }
}
