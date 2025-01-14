class KichThuocSanPham {
  final int id;
  final String tenKichThuoc;

  KichThuocSanPham({required this.id, required this.tenKichThuoc});

  // Factory method to parse JSON
  factory KichThuocSanPham.fromJson(Map<String, dynamic> json) {
    return KichThuocSanPham(
      id: json['id'] as int,
      tenKichThuoc: json['ten_kich_thuoc'] as String,
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_kich_thuoc': tenKichThuoc,
    };
  }
}
