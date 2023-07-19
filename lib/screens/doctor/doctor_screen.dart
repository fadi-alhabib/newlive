import 'package:flutter/material.dart';
import 'package:hospital/models/doctor_model.dart';
import 'package:hospital/screens/doctor/add_diognses_screen.dart';
import 'package:hospital/screens/doctor/doctor_oppoitments.dart';
import 'package:hospital/screens/doctor/profile_screen.dart';
import 'package:hospital/utils/constants.dart';

class DoctorScreen extends StatefulWidget {
  final DoctorModel doctor;
  const DoctorScreen({super.key, required this.doctor});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          foregroundColor: Colors.black,
          title: const Text("Doctor Section"),
          centerTitle: true,
          bottom: TabBar(
              controller: tabController,
              indicatorColor: Colors.black,
              tabs: const [
                Tab(text: "Appointments"),
                Tab(
                  text: "Diognses",
                ),
                Tab(
                  text: "Profile",
                ),
              ]),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            DoctorAppoitmentsScreen(),
            AddDiognsesScreen(),
            ProfileScreen(
              doctor: widget.doctor,
            )
          ],
        ));
  }
}
