import 'package:kingofshoes/models/anh_sp.dart';

class BienTheSanPham {
  final int id;
  final int san_pham_id;
  final String ten_bien_the;
  final int mau_id;
  final int kich_thuoc_id;
  int so_luong;
  final double gia_ban;
  final int id_anh;
  final String trang_thai;
  final int ma_giam_gia;
  final double? gia_nhap;
  final AnhSp? anhSp;
  final String? mo_ta;

  BienTheSanPham(
      {required this.id,
      required this.san_pham_id,
      required this.ten_bien_the,
      required this.mau_id,
      required this.kich_thuoc_id,
      required this.so_luong,
      required this.gia_ban,
      required this.id_anh,
      required this.trang_thai,
      required this.ma_giam_gia,
      required this.gia_nhap,
      required this.anhSp,
      required this.mo_ta});

  factory BienTheSanPham.fromJson(Map<String, dynamic> json) {
    return BienTheSanPham(
      id: json['id'] ?? 0,
      san_pham_id: json['san_pham_id'] ?? 0,
      ten_bien_the: json['ten_bien_the'] ?? '',
      mau_id: json['mau_id'] ?? 0,
      kich_thuoc_id: json['kich_thuoc_id'] ?? 0,
      so_luong: json['so_luong'] ?? 0,
      gia_ban: json['gia_ban'] != null ? double.parse(json['gia_ban']) : 0.0,
      id_anh: json['id_anh'] ?? 0,
      trang_thai: json['trang_thai'] ?? '',
      ma_giam_gia: json['ma_giam_gia'] ?? 0,
      gia_nhap: json['gia_nhap'] != null ? double.parse(json['gia_nhap']) : 0.0,
      anhSp: json['anh'] != null ? AnhSp.fromJson(json['anh']) : null,
      mo_ta: json['mo_ta'] ?? '',
    );
  }
}
