import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/components/components.dart';
import 'package:hospital/cubit/app_cubit.dart';
import 'package:hospital/screens/doctor/doctor_screen.dart';
import '/components/text_field.dart';

import '../utils/constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final userNameControlller = TextEditingController();
  final passwordControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'images/login.png',
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'This section is for Doctors',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      MyTextField().build(context,
                          lable: const Text("Username"), validator: (value) {
                        if (value!.isEmpty) {
                          return "username is required";
                        }
                        return null;
                      }, controller: userNameControlller),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField().build(context,
                          lable: const Text("Password"), validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      }, controller: passwordControlller),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: BlocConsumer<AppCubit, AppState>(
                      listener: (context, state) {
                        if (state is LoginLoadingState) {
                          showLoadingDialog(context);
                        }
                        if (state is LoginSuccessState) {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => DoctorScreen(
                                        doctor: state.doctor,
                                      )));
                        }
                        if (state is LoginFailureState) {
                          Navigator.of(context).pop();
                          if (state.statusCode == 500) {
                            showResult(context,
                                keys: [""], values: ["Internal Server Error"]);
                          } else {
                            showResult(context, keys: [
                              ""
                            ], values: [
                              "Couldn't log you in, please check the username and password"
                            ]);
                          }
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                state is! LoginLoadingState) {
                              cubit.login(userNameControlller.text.trim(),
                                  passwordControlller.text.trim());
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('Login'),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
