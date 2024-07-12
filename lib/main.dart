import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/controller/signup/bloc/signup_bloc.dart';
import 'package:flutter_application_1/views/screens/signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return
      BlocProvider(
          create: (context) => SignupBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
      
      title: 'Flutter Firebase BLoC Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: SignupScreen(),
    ) ,
        );
    
    
    
  }
}
