class DoctorModel {
  final String doctorName;
  final int doctorId;
  final int doctorAge;
  final String dAddress;
  final String dPhone;
  final String dEmail;
  final String dGender;
  final String dSpcelization;
  final String hireDate;

  DoctorModel(
      this.doctorName,
      this.doctorId,
      this.doctorAge,
      this.dAddress,
      this.dPhone,
      this.dEmail,
      this.dGender,
      this.dSpcelization,
      this.hireDate);

  DoctorModel.fromJson(Map<String, dynamic> json)
      : doctorName = json['doctorName'],
        doctorId = json['doctorId'],
        doctorAge = json['doctorAge'],
        dAddress = json['dAddress'],
        dPhone = json['dPhone'],
        dEmail = json['dEmail'],
        dGender = json['dGender'],
        dSpcelization = json['dSpcelization'],
        hireDate = json['hireDate'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctorName'] = doctorName;
    data['doctorId'] = doctorId;
    data['doctorAge'] = doctorAge;
    data['dAddress'] = dAddress;
    data['dPhone'] = dPhone;
    data['dEmail'] = dEmail;
    data['dGender'] = dGender;
    data['dSpcelization'] = dSpcelization;
    data['hireDate'] = hireDate;
    return data;
  }
}
