import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/cubit/app_cubit.dart';
import 'package:hospital/utils/cache.dart';
import 'utils/constants.dart';
import 'screens/splash_screen.dart';

import 'utils/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(BlocProvider(
    create: (context) => AppCubit()..getAllDoctors(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: getMaterialColor(mainColor as Color)),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
