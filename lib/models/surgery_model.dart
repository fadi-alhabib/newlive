class SurgeryModel {
  final String surgeryDate;
  final String surgeryRoom;
  final double surgeryTime;
  final String surgeryType;
  final String doctorIdName;
  final int patientId;

  SurgeryModel(this.surgeryDate, this.surgeryRoom, this.surgeryTime,
      this.surgeryType, this.doctorIdName, this.patientId);
  SurgeryModel.fromJson(Map<String, dynamic> json)
      : surgeryDate = json["surgeryDate"],
        surgeryRoom = json["surgeryRoom"],
        surgeryTime = json["surgeryTime"],
        surgeryType = json["surgeryType"],
        doctorIdName = json["doctorIdName"],
        patientId = json["patientId"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['surgeryDate'] = surgeryDate;
    data['surgeryRoom'] = surgeryRoom;
    data['surgeryTime'] = surgeryTime;
    data['surgeryType'] = surgeryType;
    data['doctorIdName'] = doctorIdName;
    data['patientId'] = patientId;
    return data;
  }
}
