class User {
  final String? MaSV;
  final String? TenSV;
  final String? NamSinh;
  final String? Khoa;
  final String? GioiTinh;
  final String? CCCD;
  final String? Email;
  final String? Sdt;
  User({
    this.MaSV,
    this.TenSV,
    this.Khoa,
    this.NamSinh,
    this.GioiTinh,
    this.CCCD,
    this.Email,
    this.Sdt,
  });

   factory User.fromJson(Map<String, dynamic> json) {
    return User(
        MaSV: json['MaSV'] ?? -1,
        TenSV: json['TenSV'] ?? "",
        Khoa: json['Khoa'] ?? "",
        NamSinh: json['NamSinh'] ?? "",
        GioiTinh: json['GioiTinh'] ?? "",
        CCCD: json['CCCD'] ?? "",
        Email: json['Email'] ?? "",
        Sdt: json['Sdt'] ?? "");
    }
  Map<String, dynamic> toJson() => {
      'MaSV': MaSV,
      'TenSV': TenSV,
      'NamSinh': NamSinh,
      'Khoa': Khoa,
      'GioiTinh': GioiTinh,
      'CCCD': CCCD,
      'Email': Email,
      'Sdt': Sdt,
    };
}