import 'package:kingofshoes/models/bien_the_san_pham.dart';

class SanPham {
  final int id;
  final String ten;
  final double gia;
  final String moTa;
  final String idAnh;
  final List<BienTheSanPham> bienThe;

  SanPham(
      {required this.id,
      required this.ten,
      required this.gia,
      required this.idAnh,
      required this.moTa,
      required this.bienThe});

  factory SanPham.fromJson(Map<String, dynamic> json) {
    return SanPham(
      id: json['id'] ?? 0,
      ten: json['ten'] ?? '',
      gia: double.tryParse(json['gia'] ?? '0') ?? 0.0,
      moTa: json['mo_ta'] ?? '',
      idAnh: json['id_anh']['duong_dan_anh'] ?? '',
      bienThe: json['bien_the'] != null
          ? List<BienTheSanPham>.from(json['bien_the']
              .map((bienThe) => BienTheSanPham.fromJson(bienThe)))
          : [],
    );
  }
}
