class MaHocPhanModel {
  String? TenHocPhan;
  String? MaHocPhan;

  MaHocPhanModel(
      {this.TenHocPhan, this.MaHocPhan});
  factory MaHocPhanModel.fromJson(Map<String, dynamic> json) {
    return MaHocPhanModel(
        TenHocPhan: json['TenHocPhan'] ?? "",
        MaHocPhan: json['MaHocPhan'] ?? "",
        );
  }

  Map<String, dynamic> toJson() => {
        "TenHocPhan": TenHocPhan,
        "MaHocPhan": MaHocPhan,
      };
}
