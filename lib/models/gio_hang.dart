import 'package:kingofshoes/models/bien_the_san_pham.dart';

class GioHang {
  final int idGioHang;
  final int idKhachHang;
  final DateTime ngaytao;
  final int soluong;
  final int id_bien_the;
  final List<BienTheSanPham> bienTheSanPham;

  GioHang({
    required this.idGioHang,
    required this.idKhachHang,
    required this.ngaytao,
    required this.soluong,
    required this.id_bien_the,
    required this.bienTheSanPham,
  });

  factory GioHang.fromJson(Map<String, dynamic> json) {
    return GioHang(
      idGioHang: json['id_gio_hang'] ?? 0,
      idKhachHang: json['id_khach_hang'] ?? 0,
      ngaytao: DateTime.parse(json['ngay_tao'] ?? '1970-01-01T00:00:00Z'),
      soluong: json['so_luong'] ?? 0,
      id_bien_the: json['id_bien_the'] ?? 0,
      bienTheSanPham: (json['bienthesanpham'] as List)
          .map((item) => BienTheSanPham.fromJson(item))
          .toList(),
    );
  }
}
