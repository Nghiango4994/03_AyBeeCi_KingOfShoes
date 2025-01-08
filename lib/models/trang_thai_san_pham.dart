class TrangThaiSanPham {
  final String id;
  final String tenTrangThai;

  TrangThaiSanPham({required this.id, required this.tenTrangThai});

  // Phương thức để chuyển đổi từ JSON sang đối tượng TrangThaiSanPham
  factory TrangThaiSanPham.fromJson(Map<String, dynamic> json) {
    return TrangThaiSanPham(
      id: json['id'],
      tenTrangThai: json['ten_trang_thai'],
    );
  }

  // Phương thức để chuyển đổi từ đối tượng TrangThaiSanPham sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_trang_thai': tenTrangThai,
    };
  }
}
