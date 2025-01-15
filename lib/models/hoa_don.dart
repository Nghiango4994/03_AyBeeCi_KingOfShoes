import 'package:kingofshoes/models/trang_thai_van_chuyen.dart';

class HoaDon {
  final int hoaDonId;
  final int? khachHangId;
  final int hinhThucThanhToanId;
  final DateTime ngayLap;
  final int? idMaGiamGia;
  final int? trangThaiVanChuyen;
  final int? trangThaiThanhToan;

  HoaDon({
    required this.hoaDonId,
    this.khachHangId,
    required this.hinhThucThanhToanId,
    required this.ngayLap,
    this.idMaGiamGia,
    this.trangThaiVanChuyen,
    this.trangThaiThanhToan,
  });

  // Phương thức chuyển đổi từ JSON sang đối tượng
  factory HoaDon.fromJson(Map<String, dynamic> json) {
    return HoaDon(
      hoaDonId: json['HoaDon_Id'],
      khachHangId: json['KhachHang_Id'],
      hinhThucThanhToanId: json['HinhThucThanhToan_Id'],
      ngayLap: DateTime.parse(json['ngay_lap']),
      idMaGiamGia: json['id_Ma_Giam_Gia'],
      trangThaiVanChuyen: json['trang_thai_van_chuyen'],
      trangThaiThanhToan: json['trang_thai_thanh_toan'],
    );
  }

  // Phương thức chuyển đổi từ đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'HoaDon_Id': hoaDonId,
      'KhachHang_Id': khachHangId,
      'HinhThucThanhToan_Id': hinhThucThanhToanId,
      'ngay_lap': ngayLap.toIso8601String(),
      'id_Ma_Giam_Gia': idMaGiamGia,
      'trang_thai_van_chuyen': trangThaiVanChuyen,
      'trang_thai_thanh_toan': trangThaiThanhToan,
    };
  }
}
