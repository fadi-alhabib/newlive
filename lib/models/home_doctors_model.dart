class HomeDoctorsModel {
  final int doctorId;
  final String doctorname;
  final String sectionName;

  HomeDoctorsModel({
    required this.doctorId,
    required this.doctorname,
    required this.sectionName,
  });

  HomeDoctorsModel.fromJson(Map<String, dynamic> json)
      : doctorId = json['doctorId'],
        doctorname = json['doctorname'],
        sectionName = json['sectionName'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctorId'] = doctorId;
    data['doctorname'] = doctorname;
    data['sectionName'] = sectionName;
    return data;
  }
}
