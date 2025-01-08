// lib/models/hoa_don.dart
class HoaDon {
  int? HoaDon_Id;
  int? KhachHang_Id;
  int? HinhThucThanhToan;
  DateTime? ngay_lap;
  int id_Ma_giam_Gia;

  HoaDon({
    required this.HoaDon_Id,
    required this.KhachHang_Id,
    required this.HinhThucThanhToan,
    required this.id_Ma_giam_Gia,
    required this.ngay_lap,
  });

  // Phương thức từ JSON
  factory HoaDon.fromJson(Map<String, dynamic> json) {
    return HoaDon(
      HoaDon_Id: json['hoa_don_id'],
      KhachHang_Id: json['khach_hang_id'],
      HinhThucThanhToan: json['hinh_thuc_thanh_toan'],
      id_Ma_giam_Gia: json['id_ma_giam_gia'],
      ngay_lap:
          json['ngay_lap'] != null ? DateTime.parse(json['ngay_lap']) : null,
    );
  }

  // Phương thức chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'hoa_don_id': HoaDon_Id,
      'khach_hang_id': KhachHang_Id,
      'hinh_thuc_thanh_toan': HinhThucThanhToan,
      'id_ma_giam_gia': id_Ma_giam_Gia,
      'ngay_lap':
          ngay_lap?.toIso8601String(), // Chuyển đổi DateTime sang String
    };
  }
}
