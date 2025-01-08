// lib/models/chi_tiet_gio_hang.dart
class ChiTietGioHang {
  int idChiTietGioHang;
  int idGioHang;
  int idSanPham;
  int soLuong;
  DateTime? ngayTao;

  ChiTietGioHang({
    required this.idChiTietGioHang,
    required this.idGioHang,
    required this.idSanPham,
    this.soLuong = 1,
    DateTime? ngayTao,
  }) : this.ngayTao = ngayTao ?? DateTime.now();

  // Phương thức từ JSON
  factory ChiTietGioHang.fromJson(Map<String, dynamic> json) {
    return ChiTietGioHang(
      idChiTietGioHang: json['id_chi_tiet_gio_hang'],
      idGioHang: json['id_gio_hang'],
      idSanPham: json['id_san_pham'],
      soLuong: json['so_luong'] ?? 1,
      ngayTao:
          json['ngay_tao'] != null ? DateTime.parse(json['ngay_tao']) : null,
    );
  }

  // Phương thức chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id_chi_tiet_gio_hang': idChiTietGioHang,
      'id_gio_hang': idGioHang,
      'id_san_pham': idSanPham,
      'so_luong': soLuong,
      'ngay_tao': ngayTao?.toIso8601String(), // Chuyển đổi DateTime sang String
    };
  }
}
