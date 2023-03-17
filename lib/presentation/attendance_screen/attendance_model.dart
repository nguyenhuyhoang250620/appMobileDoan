class AttendanceModel {
  final int id;
  final String name;
  final String masv;
  final String timeOut;
  final String timeIn;
  final String image;

  AttendanceModel({required this.id, required this.name, required this.masv, required this.timeOut, required this.timeIn,required this.image,});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      masv: json['masv'] as String,
      timeOut: json['timeOut'] as String,
      timeIn: json['timeIn'] as String,
      image: json['image'] as String,
    );
  }
}