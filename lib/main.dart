import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnunittest/screens/user_page.dart';
import 'bloc/user/user_bloc.dart';
import 'bloc/user/user_repository.dart';

void main() {
  final UserRepository userRepository = UserRepository();

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => UserBloc(userRepository: userRepository),
        child: UserPage(),
      ),
    );
  }
}


