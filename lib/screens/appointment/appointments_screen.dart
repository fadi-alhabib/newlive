import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/cubit/app_cubit.dart';
import 'package:hospital/screens/appointment/book_screen.dart';

import '/components/components.dart';
import '/components/text_field.dart';

import '../../utils/constants.dart';

class AppointmentsScreen extends StatelessWidget {
  AppointmentsScreen({super.key});
  final appointmentController = TextEditingController();
  final surgeryController = TextEditingController();
  final diagousesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('My Appointments'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookScreen(),
                ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          "My Appointment",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        MyTextField().build(context,
                            hint: "Enter your name",
                            controller: appointmentController),
                        Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: BlocConsumer<AppCubit, AppState>(
                              listener: (context, state) {
                                if (state is GetAppoitmentsLoadingState) {
                                  showLoadingDialog(context);
                                }
                                if (state is GetAppoitmentsSuccessState) {
                                  Navigator.of(context).pop();
                                  showResult(context,
                                      keys: state.appointment
                                          .toJson()
                                          .keys
                                          .toList(),
                                      values: state.appointment
                                          .toJson()
                                          .values
                                          .toList());
                                }
                                if (state is GetAppoitmentsFailureState) {
                                  Navigator.of(context).pop();
                                  String message = "";
                                  if (state.statusCode == 404) {
                                    message =
                                        "User Not Found, Check the name please";
                                  } else {
                                    message =
                                        "Something Wrong Happend, Please Try Again Later";
                                  }
                                  showResult(context,
                                      keys: [""], values: [message]);
                                }
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                    onPressed: () {
                                      if (state
                                          is! GetAppoitmentsLoadingState) {
                                        cubit.getAppointments(
                                            appointmentController.text);
                                      }
                                    },
                                    child: const Text("Get my appointment"));
                              },
                            ))
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        MyTextField().build(context,
                            hint: "Enter your ID",
                            controller: surgeryController),
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
                                    values:
                                        state.surgery.toJson().values.toList());
                              }
                              if (state is GetSurgeryFailureState) {
                                Navigator.of(context).pop();
                                String message = "";
                                if (state.statusCode == 404) {
                                  message =
                                      "User Not Found, Check the id please";
                                } else {
                                  message =
                                      "Something Wrong Happend, Please Try Again Later";
                                }
                                showResult(context,
                                    keys: [""], values: [message]);
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                  onPressed: () {
                                    if (state is! GetSurgeryLoadingState) {
                                      int pid =
                                          int.parse(surgeryController.text);
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
                          "My Diagnoses",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        MyTextField().build(context,
                            hint: "Enter your ID",
                            controller: diagousesController),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: BlocConsumer<AppCubit, AppState>(
                            listener: (context, state) {
                              if (state is GetDiaougnsesLoadingState) {
                                showLoadingDialog(context);
                              }
                              if (state is GetDiaougnsesSuccessState) {
                                Navigator.of(context).pop();
                                showResult(context,
                                    keys: state.diagnose.toJson().keys.toList(),
                                    values: state.diagnose
                                        .toJson()
                                        .values
                                        .toList());
                              }
                              if (state is GetDiaougnsesFailureState) {
                                Navigator.of(context).pop();
                                String message = "";
                                if (state.statusCode == 404) {
                                  message =
                                      "User Not Found, Check the id please";
                                } else {
                                  message =
                                      "Something Wrong Happend, Please Try Again Later";
                                }
                                showResult(context,
                                    keys: [""], values: [message]);
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                  onPressed: () {
                                    if (state is! GetDiaougnsesLoadingState) {
                                      cubit.getDiagnouse(
                                          int.parse(diagousesController.text));
                                    }
                                  },
                                  child: const Text("Get my diaougnases"));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
