// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_elisoft/constant/constant.dart';
import 'package:flutter_test_elisoft/presentation/bloc/login_cubit.dart';
import 'package:flutter_test_elisoft/presentation/bloc/user_cubit.dart';
import 'package:flutter_test_elisoft/presentation/pages/dashboard_page.dart';
import 'package:flutter_test_elisoft/service/api_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController username =
      TextEditingController(text: 'rachman.latif@gmail.com');
  TextEditingController password = TextEditingController(text: 'testing');

  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 19, right: 19),
        child: ListView(
          children: [
            Image.asset('assets/img_login.png'),
            TextField(
                cursorColor: const Color.fromRGBO(36, 120, 129, 1),
                controller: username,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldC,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: 'Username',
                  labelStyle: const TextStyle(
                    color: Color.fromRGBO(0, 103, 120, 1),
                  ),
                )),
            const SizedBox(
              height: 13,
            ),
            BlocBuilder<LoginCubit, Map>(
              builder: (context, state) {
                return TextField(
                    cursorColor: const Color.fromRGBO(36, 120, 129, 1),
                    controller: password,
                    obscureText: state['obsecureText'],
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldC,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(0, 103, 120, 1),
                        ),
                        suffixIcon: InkWell(
                            onTap: () {
                              loginCubit.changeState();
                            },
                            child: state['iconSecure'])));
              },
            ),
            const SizedBox(
              height: 45,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(36, 120, 129, 1))),
              child: const SizedBox(
                  height: 56, child: Center(child: Text('Login'))),
              onPressed: () {
                if (password.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Material(
                              color: const Color.fromRGBO(178, 39, 39, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.error,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            'Password cant Empty',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        loginSubmit(context);
                        return Image.asset('assets/loading.gif');
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  loginSubmit(BuildContext context) async {
    final data = await apiService.userLogin(username.text, password.text);

    if (data == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Username/Password Tidak Sesuai'),
        duration: Duration(seconds: 2),
      ));
    } else {
      context.read<UserCubit>().changeState(data);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ),
          (route) => false);
    }
  }
}
