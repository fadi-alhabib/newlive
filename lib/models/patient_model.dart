class PatientModel {
  String? patientName;
  int? patientid;
  String? gender;
  String? age;
  String? address;
  String? phonenumber;
  String? eMail;

  PatientModel(
      {this.patientName,
      this.patientid,
      this.gender,
      this.age,
      this.address,
      this.phonenumber,
      this.eMail});

  PatientModel.fromJson(Map<String, dynamic> json) {
    patientName = json['patientName'];
    patientid = json['patientid'];
    gender = json['gender'];
    age = json['age'];
    address = json['address'];
    phonenumber = json['phonenumber'];
    eMail = json['eMail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientName'] = patientName;
    data['patientid'] = patientid;
    data['gender'] = gender;
    data['age'] = age;
    data['address'] = address;
    data['phonenumber'] = phonenumber;
    data['eMail'] = eMail;
    return data;
  }
}
