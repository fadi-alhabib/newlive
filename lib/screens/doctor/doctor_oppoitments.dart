import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/components/components.dart';
import 'package:hospital/components/text_field.dart';
import 'package:hospital/cubit/app_cubit.dart';

class DoctorAppoitmentsScreen extends StatelessWidget {
  DoctorAppoitmentsScreen({super.key});
  final patientController = TextEditingController();
  final patientIDController = TextEditingController();
  final appointmentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    const Text(
                      "Patient",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    MyTextField().build(context,
                        hint: "Enter patient id",
                        controller: patientController),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: BlocConsumer<AppCubit, AppState>(
                        listener: (context, state) {
                          if (state is GetPatientByIdLoadingState) {
                            showLoadingDialog(context);
                          }
                          if (state is GetPatientByIdSuccessState) {
                            Navigator.of(context).pop();
                            showResult(context,
                                keys: state.patient.toJson().keys.toList(),
                                values: state.patient.toJson().values.toList());
                          }
                          if (state is GetPatientByIdFailureState) {
                            Navigator.of(context).pop();
                            String message = "";
                            if (state.statusCode == 404) {
                              message = "User Not Found, Check the id please";
                            } else {
                              message =
                                  "Something Wrong Happend, Please Try Again Later";
                            }
                            showResult(context, keys: [""], values: [message]);
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                              onPressed: () {
                                if (state is! GetPatientByIdLoadingState) {
                                  int patientId =
                                      int.parse(patientController.text.trim());
                                  cubit.getPatientById(patientId);
                                }
                              },
                              child: const Text("Get patient"));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    const Text(
                      "My Surgery",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    MyTextField().build(context,
                        hint: "Enter patient ID",
                        controller: patientIDController),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: BlocConsumer<AppCubit, AppState>(
                        listener: (context, state) {
                          if (state is GetSurgeryLoadingState) {
                            showLoadingDialog(context);
                          }
                          if (state is GetSurgerySuccessState) {
                            Navigator.of(context).pop();
                            showResult(context,
                                keys: state.surgery.toJson().keys.toList(),
                                values: state.surgery.toJson().values.toList());
                          }
                          if (state is GetSurgeryFailureState) {
                            Navigator.of(context).pop();
                            String message = "";
                            if (state.statusCode == 404) {
                              message = "User Not Found, Check the id please";
                            } else {
                              message =
                                  "Something Wrong Happend, Please Try Again Later";
                            }
                            showResult(context, keys: [""], values: [message]);
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                              onPressed: () {
                                if (state is! GetSurgeryLoadingState) {
                                  int pid = int.parse(
                                      patientIDController.text.trim());
                                  cubit.getSurgeries(pid);
                                }
                              },
                              child: const Text("Get my surgery"));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    const Text(
                      "My Appointment",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    MyTextField().build(context,
                        hint: "Enter your name",
                        controller: appointmentController),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                          onPressed: () {
                            showResult(context,
                                keys: ["name :"], values: ["sdfsdf"]);
                          },
                          child: const Text("Get my appointment")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
