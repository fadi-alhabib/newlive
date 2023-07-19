import 'package:flutter/material.dart';
import 'package:hospital/models/doctor_model.dart';

class ProfileScreen extends StatelessWidget {
  final DoctorModel doctor;

  const ProfileScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 85,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                "https://cdn-gfmhl.nitrocdn.com/JtDqtOWnKLCtGwmyHnwRfOFfiuBVgrda/assets/images/optimized/rev-d8a07f8/wp-content/uploads/2020/04/What-Is-An-Orthopedic-Doctor-In-Brooklyn.jpg"),
          ),
          Text(
            doctor.doctorName,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            doctor.dSpcelization,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Age : ${doctor.doctorAge}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const Text(
                "Height : 179",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Weight : 75",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "Hire date : ${doctor.hireDate.replaceRange(10, null, "")}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Appoitments : 7",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "Surgeries : 3",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const Expanded(flex: 3, child: SizedBox())
        ],
      ),
    );
  }
}
