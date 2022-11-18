import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_elisoft/presentation/bloc/user_cubit.dart';
import 'package:flutter_test_elisoft/presentation/pages/login_page.dart';

import 'presentation/bloc/login_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => UserCubit()),
        // BlocProvider(create: (_) => ListArticleCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Test Elisoft',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
