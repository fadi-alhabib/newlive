part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class LoginLoadingState extends AppState {}

class LoginSuccessState extends AppState {
  final DoctorModel doctor;

  LoginSuccessState(this.doctor);
}

class LoginFailureState extends AppState {
  final int? statusCode;

  LoginFailureState(this.statusCode);
}

class GetAppoitmentsLoadingState extends AppState {}

class GetAppoitmentsSuccessState extends AppState {
  final AppointmentModel appointment;
  GetAppoitmentsSuccessState(this.appointment);
}

class GetAppoitmentsFailureState extends AppState {
  final int? statusCode;

  GetAppoitmentsFailureState(this.statusCode);
}

class AddAppointmentLoadingState extends AppState {}

class AddAppointmentSuccessState extends AppState {
  final AppointmentModel appointment;

  AddAppointmentSuccessState(this.appointment);
}

class AddAppointmentFailureState extends AppState {
  final int? statusCode;

  AddAppointmentFailureState(this.statusCode);
}

class GetSurgeryLoadingState extends AppState {}

class GetSurgerySuccessState extends AppState {
  final SurgeryModel surgery;

  GetSurgerySuccessState(this.surgery);
}

class GetSurgeryFailureState extends AppState {
  final int? statusCode;

  GetSurgeryFailureState(this.statusCode);
}

class GetDiaougnsesLoadingState extends AppState {}

class GetDiaougnsesSuccessState extends AppState {
  final DiagnoseModel diagnose;

  GetDiaougnsesSuccessState(this.diagnose);
}

class GetDiaougnsesFailureState extends AppState {
  final int? statusCode;

  GetDiaougnsesFailureState(this.statusCode);
}

class GetPatientByIdLoadingState extends AppState {}

class GetPatientByIdSuccessState extends AppState {
  final PatientModel patient;

  GetPatientByIdSuccessState(this.patient);
}

class GetPatientByIdFailureState extends AppState {
  final int? statusCode;

  GetPatientByIdFailureState(this.statusCode);
}

class AddDiagnoseLoadingState extends AppState {}

class AddDiagnoseSuccessState extends AppState {
  final DiagnoseModel diagnose;

  AddDiagnoseSuccessState(this.diagnose);
}

class AddDiagnoseFailureState extends AppState {
  final int? statusCode;

  AddDiagnoseFailureState(this.statusCode);
}

class GetDoctorsLoadingState extends AppState {}

class GetDoctorsSuccessState extends AppState {
  final List<HomeDoctorsModel> doctors;

  GetDoctorsSuccessState(this.doctors);
}

class GetDoctorsFailureState extends AppState {
  final int? statusCode;

  GetDoctorsFailureState(this.statusCode);
}
