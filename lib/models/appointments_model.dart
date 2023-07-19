class AppointmentModel {
  final String? bookName;
  final String? bookSection;
  final String? bookDoctor;
  final String? bookDate;

  AppointmentModel({
    required this.bookName,
    required this.bookSection,
    required this.bookDoctor,
    required this.bookDate,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json)
      : bookName = json["bookname"],
        bookSection = json["booksection"],
        bookDoctor = json["bookdoctor"],
        bookDate = json["bookdate"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookname'] = bookName;
    data['booksection'] = bookSection;
    data['bookdoctor'] = bookDoctor;
    data['bookdate'] = bookDate;
    return data;
  }
}
