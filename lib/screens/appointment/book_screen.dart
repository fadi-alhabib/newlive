import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/components/components.dart';

import 'package:hospital/components/text_field.dart';
import 'package:hospital/cubit/app_cubit.dart';
import 'package:hospital/models/appointments_model.dart';
import 'package:hospital/utils/constants.dart';

class BookScreen extends StatelessWidget {
  BookScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final List<String> bookSections = [
    'Pediatrics',
    'Dentist',
    'Heart Surgery',
    'Psychiatry',
    'Kidney Disease',
    'Gastrointestial Disease',
    'Neurology',
    'Orthopedics'
  ];
  final List<String> doctorsName = ['DR omar jalal', 'DR farah waleed'];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    late String? bookSection;
    late String? doctorName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Book Your Appointment'),
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              MyTextField().build(context, lable: const Text("Name"),
                  validator: (value) {
                if (value!.isEmpty) {
                  return "This Field is required";
                }
                return null;
              }, controller: nameController),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  hint: const Text("Doctor Name"),
                  isExpanded: true,
                  items: doctorsName
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    doctorName = value;
                    print(doctorName);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  hint: const Text("Book Section"),
                  isExpanded: true,
                  items: bookSections
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    bookSection = value;
                    print(bookSection);
                  },
                ),
              ),
              MyTextField().build(context,
                  keyboardType: TextInputType.none,
                  controller: dateController,
                  lable: const Text("Date"), onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 7)))
                    .then((value) {
                  dateController.text = value.toString().split(" ").first;
                });
              }),
              BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (state is AddAppointmentLoadingState) {
                    showLoadingDialog(context);
                  }
                  if (state is AddAppointmentSuccessState) {
                    Navigator.of(context).pop();
                    showResult(context,
                        keys: state.appointment.toJson().keys.toList(),
                        values: state.appointment.toJson().values.toList());
                  }
                  if (state is AddAppointmentFailureState) {
                    Navigator.of(context).pop();
                    String message =
                        "Something Wrong Happend, Please Try Again Later";
                    showResult(context, keys: [""], values: [message]);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          state is! AddAppointmentLoadingState) {
                        AppointmentModel appointment = AppointmentModel(
                          bookName: nameController.text.trim(),
                          bookSection: bookSection,
                          bookDoctor: doctorName,
                          bookDate: dateController.value.text,
                        );
                        cubit.addAppointment(appointment);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Add Appointment'),
                    ),
                  );
                },
              )
            ],
          )),
    );
  }
}
