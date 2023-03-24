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
class Student {
  String gioiTinh;
  String email;
  String maSV;
  String namSinh;
  String soDT;
  String khoa;
  String cccd;
  String tenSV;

  Student({
    required this.gioiTinh,
    required this.email,
    required this.maSV,
    required this.namSinh,
    required this.soDT,
    required this.khoa,
    required this.cccd,
    required this.tenSV,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      gioiTinh: json['GioiTinh'],
      email: json['Email'],
      maSV: json['MaSV'],
      namSinh: json['NamSinh'],
      soDT: json['SoDT'],
      khoa: json['Khoa'],
      cccd: json['CCCD'],
      tenSV: json['TenSV'],
    );
  }
  }