import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/models/home_doctors_model.dart';
import 'package:hospital/models/patient_model.dart';
import 'package:hospital/utils/cache.dart';
import 'package:hospital/utils/dio_helper.dart';
import 'package:hospital/models/appointments_model.dart';
import 'package:hospital/models/diagnose_model.dart';
import 'package:hospital/models/doctor_model.dart';
import 'package:hospital/models/surgery_model.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  Future<void> getAppointments(String pName) async {
    emit(GetAppoitmentsLoadingState());
    try {
      String path = Uri.parse('Appointments/$pName').toString();
      Response? response = await DioHelper.getData(path: path);
      AppointmentModel appointment = AppointmentModel.fromJson(response?.data);
      emit(GetAppoitmentsSuccessState(appointment));
    } on DioError catch (e) {
      emit(GetAppoitmentsFailureState(e.response?.statusCode));
    }
  }

  Future<void> getSurgeries(int pid) async {
    emit(GetSurgeryLoadingState());
    try {
      String path = Uri.parse('Sugeries/$pid').toString();
      Response? response = await DioHelper.getData(path: path);
      SurgeryModel surgery = SurgeryModel.fromJson(response?.data);
      emit(GetSurgerySuccessState(surgery));
    } on DioError catch (e) {
      emit(GetSurgeryFailureState(e.response?.statusCode));
    }
  }

  Future<void> getDiagnouse(int pid) async {
    emit(GetDiaougnsesLoadingState());
    try {
      String path = Uri.parse('Diagnouse/$pid').toString();
      Response? response = await DioHelper.getData(path: path);
      DiagnoseModel diagnose = DiagnoseModel.fromJson(response?.data);
      emit(GetDiaougnsesSuccessState(diagnose));
    } on DioError catch (e) {
      emit(GetDiaougnsesFailureState(e.response?.statusCode));
    }
  }

  Future<void> login(String username, String password) async {
    emit(LoginLoadingState());
    try {
      Map<String, dynamic> data = {
        "username": username.trim(),
        "password": password.trim(),
        "usertype": "doctor"
      };
      Response? response = await DioHelper.postData(path: "Login", data: data);
      DoctorModel doctor = DoctorModel.fromJson(response?.data);
      String jwt = response!.headers.map["token"]![0];
      await CacheHelper.setCache(key: "token", value: jwt);
      await CacheHelper.setCache(
          key: "doctor", value: jsonEncode(doctor.toJson()));
      emit(LoginSuccessState(doctor));
    } on DioError catch (e) {
      emit(LoginFailureState(e.response?.statusCode));
    }
  }

  Future<void> getPatientById(int pid) async {
    emit(GetPatientByIdLoadingState());
    String token = await CacheHelper.getCache(key: "token");
    print(token);
    try {
      String path = Uri.parse("Patients/$pid").toString();
      Response? response = await DioHelper.getData(path: path, token: token);
      PatientModel patient = PatientModel.fromJson(response?.data);
      emit(GetPatientByIdSuccessState(patient));
    } on DioError catch (e) {
      emit(GetPatientByIdFailureState(e.response?.statusCode));
    }
  }

  Future<void> addDiagnose(DiagnoseModel diagnose) async {
    emit(AddDiagnoseLoadingState());
    String token = await CacheHelper.getCache(key: "token");
    try {
      String path = "Diagnose";

      Response? response = await DioHelper.postData(
          path: path, data: diagnose.toJson(), token: token);
      DiagnoseModel diagnoseModel = DiagnoseModel.fromJson(response?.data);
      emit(AddDiagnoseSuccessState(diagnoseModel));
    } on DioError catch (e) {
      emit(AddDiagnoseFailureState(e.response?.statusCode));
    }
  }

  Future<void> getAllDoctors() async {
    emit(GetDoctorsLoadingState());
    try {
      String path = "Doctors";
      Response? response = await DioHelper.getData(path: path);
      List<HomeDoctorsModel> doctorsList = [];
      response?.data.forEach(
          (doctor) => doctorsList.add(HomeDoctorsModel.fromJson(doctor)));
      // await CacheHelper.setCache(
      //     key: "doctorsList", value: jsonEncode(doctorsList));
      print(doctorsList);
      emit(GetDoctorsSuccessState(doctorsList));
    } on DioError catch (e) {
      emit(GetDoctorsFailureState(e.response?.statusCode));
    }
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    emit(AddAppointmentLoadingState());
    try {
      String path = "Appointments";
      Response? response =
          await DioHelper.postData(path: path, data: appointment.toJson());
      AppointmentModel createdAppointment =
          AppointmentModel.fromJson(response?.data);
      emit(AddAppointmentSuccessState(createdAppointment));
    } on DioError catch (e) {
      emit(AddAppointmentFailureState(e.response?.statusCode));
    }
  }
}
