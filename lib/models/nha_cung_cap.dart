class NhaCungCap {
  final int id;
  final String tenNhaCungCap;
  final String? diaChi;
  final String? sdt;

  NhaCungCap({
    required this.id,
    required this.tenNhaCungCap,
    this.diaChi,
    this.sdt,
  });

  factory NhaCungCap.fromJson(Map<String, dynamic> json) {
    return NhaCungCap(
      id: json['id'],
      tenNhaCungCap: json['ten_nha_cung_cap'],
      diaChi: json['dia_chi'],
      sdt: json['sdt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_nha_cung_cap': tenNhaCungCap,
      'dia_chi': diaChi,
      'sdt': sdt,
    };
  }
}
