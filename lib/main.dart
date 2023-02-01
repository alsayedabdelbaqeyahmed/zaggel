import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zagel/api_key.dart';
import 'package:zagel/auth_screen/presentation/cubit/auth_cubit.dart';
import 'package:zagel/auth_screen/presentation/view/auth_screen.dart';
import 'package:zagel/complete_user_profie/presentattion/cubit/user_profile_cubit.dart';
import 'package:zagel/firebase_options.dart';
import 'package:zagel/styles/routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // ignore: prefer_const_constructors
    options: FirebaseOptions(
      apiKey: apiKey!,
      appId: 'zageel',
      messagingSenderId: '',
      projectId: 'zageel',
    ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => AuthCubit()),
        ),
        BlocProvider(
          create: ((context) => ProfileCubit()),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(),
      routes: routes!,
    );
  }
}
