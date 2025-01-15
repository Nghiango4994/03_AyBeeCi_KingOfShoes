class TrangThaiVanChuyen {
  final int id;
  final String tenTrangThai;
  final DateTime? gioXacNhan;
  final DateTime? gioHuyXacNhan;

  TrangThaiVanChuyen({
    required this.id,
    required this.tenTrangThai,
    this.gioXacNhan,
    this.gioHuyXacNhan,
  });

  // Phương thức chuyển đổi từ JSON sang đối tượng
  factory TrangThaiVanChuyen.fromJson(Map<String, dynamic> json) {
    return TrangThaiVanChuyen(
      id: json['id'],
      tenTrangThai: json['ten_trang_thai'],
      gioXacNhan: json['gio_xac_nhan'] != null
          ? DateTime.parse(json['gio_xac_nhan'])
          : null,
      gioHuyXacNhan: json['gio_huy_xac_nhan'] != null
          ? DateTime.parse(json['gio_huy_xac_nhan'])
          : null,
    );
  }

  // Phương thức chuyển đổi từ đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_trang_thai': tenTrangThai,
      'gio_xac_nhan': gioXacNhan?.toIso8601String(),
      'gio_huy_xac_nhan': gioHuyXacNhan?.toIso8601String(),
    };
  }
}
