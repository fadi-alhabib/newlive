import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/cubit/app_cubit.dart';
import 'package:hospital/models/doctor_model.dart';
import 'package:hospital/screens/appointment/appointments_screen.dart';
import 'package:hospital/screens/appointment/notification_screen.dart';
import 'package:hospital/screens/doctor/doctor_screen.dart';
import 'package:hospital/utils/cache.dart';
import 'package:hospital/utils/constants.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('New Live Hospital'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ));
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AppointmentsScreen(),
                ));
              },
              child: Card(
                color: Colors.grey[200],
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Appointments',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'show all your appointments',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Our Departments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade300.withAlpha(100),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.pills,
                            size: 35,
                            color: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Medicine',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade300.withAlpha(100),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.hospital,
                            size: 35,
                            color: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Hospital',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade300.withAlpha(100),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.userDoctor,
                            size: 35,
                            color: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Doctor',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Our Doctors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                if (state is GetDoctorsLoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is GetDoctorsSuccessState) {
                  return Expanded(
                    child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      children: state.doctors
                          .map(
                            (e) => Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    "https://th.bing.com/th/id/R.5037bf82b9b05163901225ccd8102522?rik=Gzv6zi08z0vqxA&pid=ImgRaw&r=0",
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    e.doctorname,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(e.sectionName)
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
                return const Text("Something Wrong Happend");
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            String? token = CacheHelper.getCache(key: "token");

            if (token != null) {
              Map<String, dynamic> cachedDoctor =
                  jsonDecode(CacheHelper.getCache(key: "doctor"));
              DoctorModel doctor = DoctorModel.fromJson(cachedDoctor);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DoctorScreen(
                        doctor: doctor,
                      )));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            }
          },
          child: const Icon(
            Icons.health_and_safety_rounded,
            color: Colors.white,
          )),
    );
  }
}
