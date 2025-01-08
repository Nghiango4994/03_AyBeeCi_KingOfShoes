// lib/models/gio_hang.dart
class GioHang {
  int id_gio_hang;
  int id_khach_hang;
  int id_san_pham;
  int SoLuong;
  int tong_don_gia;

  GioHang({
    required this.id_gio_hang,
    required this.id_khach_hang,
    required this.SoLuong,
    required this.id_san_pham,
    required this.tong_don_gia,
  });

  // Phương thức từ JSON
  factory GioHang.fromJson(Map<String, dynamic> json) {
    return GioHang(
      id_gio_hang: json['id_gio_hang'],
      id_khach_hang: json['id_khach_hang'],
      id_san_pham: json['id_san_pham'],
      SoLuong: json['so_luong'],
      tong_don_gia: json['tong_don_gia'],
    );
  }

  // Phương thức chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id_gio_hang': id_gio_hang,
      'id_khach_hang': id_khach_hang,
      'id_san_pham': id_san_pham,
      'so_luong': SoLuong,
      'tong_don_gia': tong_don_gia,
    };
  }
}
