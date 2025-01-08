// lib/models/anh_sp.dart
class AnhSP {
  String id;
  String? duongDanAnh;
  int idSanPham;
  int idMauSP;

  AnhSP({
    required this.id,
    this.duongDanAnh,
    required this.idSanPham,
    required this.idMauSP,
  });

  // Phương thức từ JSON
  factory AnhSP.fromJson(Map<String, dynamic> json) {
    return AnhSP(
      id: json['id'],
      duongDanAnh: json['duong_dan_anh'],
      idSanPham: json['id_san_pham'],
      idMauSP: json['id_mau_sp'],
    );
  }

  // Phương thức chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'duong_dan_anh': duongDanAnh,
      'id_san_pham': idSanPham,
      'id_mau_sp': idMauSP,
    };
  }
}
