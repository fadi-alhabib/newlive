class DiagnoseModel {
  final int patientId;
  final String patientName;
  final String doctorName;
  final String digognses;

  DiagnoseModel({
    required this.patientId,
    required this.patientName,
    required this.doctorName,
    required this.digognses,
  });

  DiagnoseModel.fromJson(Map<String, dynamic> json)
      : patientId = json['patientId'],
        patientName = json['patientName'],
        doctorName = json['doctorName'],
        digognses = json['digognses'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientId'] = patientId;
    data['patientName'] = patientName;
    data['doctorName'] = doctorName;
    data['digognses'] = digognses;
    return data;
  }
}
