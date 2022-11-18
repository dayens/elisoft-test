import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<Map> {
  LoginCubit()
      : super(
            {'obsecureText': true, 'iconSecure': const Icon(Icons.visibility)});

  void changeState() {
    emit({
      'obsecureText': !state['obsecureText'],
      'iconSecure': state['obsecureText']
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility)
    });
  }
}
