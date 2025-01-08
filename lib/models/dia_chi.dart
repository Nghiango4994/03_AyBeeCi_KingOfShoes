// lib/models/dia_chi.dart
class DiaChi {
  int? id;
  int? id_KhachHang;
  String diachi;
  String sdt;
  bool isDefault;

  DiaChi({
    required this.id,
    required this.id_KhachHang,
    required this.diachi,
    required this.sdt,
    required this.isDefault,
  });

  // Phương thức từ JSON
  factory DiaChi.fromJson(Map<String, dynamic> json) {
    return DiaChi(
      id: json['id'],
      id_KhachHang: json['id_khach_hang'],
      diachi: json['diachi'],
      sdt: json['sdt'],
      isDefault: json['is_default'],
    );
  }

  // Phương thức chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_khach_hang': id_KhachHang,
      'diachi': diachi,
      'sdt': sdt,
      'is_default': isDefault,
    };
  }
}
