import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/components/components.dart';
import 'package:hospital/components/text_field.dart';
import 'package:hospital/cubit/app_cubit.dart';
import 'package:hospital/models/diagnose_model.dart';

class AddDiognsesScreen extends StatelessWidget {
  AddDiognsesScreen({super.key});
  final patientID = TextEditingController();
  final patientName = TextEditingController();
  final doctorName = TextEditingController();
  final diagnoseController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            MyTextField().build(context, lable: const Text("Patient ID"),
                validator: (value) {
              if (value!.isEmpty) {
                return "This field is required";
              }
              return null;
            }, controller: patientID),
            MyTextField().build(context, lable: const Text("Patient Name"),
                validator: (value) {
              if (value!.isEmpty) {
                return "This field is required";
              }
              return null;
            }, controller: patientName),
            MyTextField().build(context, lable: const Text("Doctor Name"),
                validator: (value) {
              if (value!.isEmpty) {
                return "This field is required";
              }
              return null;
            }, controller: doctorName),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.5,
              child: MyTextField().build(context,
                  keyboardType: TextInputType.multiline,
                  hint: "Description",
                  expands: true, validator: (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                }
                return null;
              }, controller: diagnoseController),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              clipBehavior: Clip.hardEdge,
              width: MediaQuery.of(context).size.width / 1.9,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (state is AddDiagnoseLoadingState) {
                    showLoadingDialog(context);
                  }
                  if (state is AddDiagnoseSuccessState) {
                    Navigator.pop(context);
                    List<dynamic> columnValues =
                        state.diagnose.toJson().values.toList();
                    columnValues.insert(
                        0, "The Diagnose with the following data where added");
                    List<String> columnKeys =
                        state.diagnose.toJson().keys.toList();
                    columnKeys.insert(0, "");
                    showResult(context, keys: columnKeys, values: columnValues);
                  }
                  if (state is AddDiagnoseFailureState) {
                    Navigator.pop(context);
                    showResult(context, keys: [
                      ""
                    ], values: [
                      "Something Wrong Happend, Please Try Again Later"
                    ]);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          state is! AddDiagnoseLoadingState) {
                        DiagnoseModel diagnose = DiagnoseModel(
                          patientId: int.parse(patientID.text.trim()),
                          patientName: patientName.text.trim(),
                          doctorName: doctorName.text.trim(),
                          digognses: diagnoseController.text.trim(),
                        );
                        cubit.addDiagnose(diagnose);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Add'),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
