class TrangThaiThanhToan {
  final int id;
  final String tenTrangThai;

  TrangThaiThanhToan({
    required this.id,
    required this.tenTrangThai,
  });

  // Phương thức chuyển đổi từ JSON sang đối tượng
  factory TrangThaiThanhToan.fromJson(Map<String, dynamic> json) {
    return TrangThaiThanhToan(
      id: json['id'],
      tenTrangThai: json['ten_trang_thai'],
    );
  }

  // Phương thức chuyển đổi từ đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_trang_thai': tenTrangThai,
    };
  }
}
