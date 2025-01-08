class KichThuocSanPham {
  final int id;
  final String tenKichThuoc;

  KichThuocSanPham({required this.id, required this.tenKichThuoc});

  factory KichThuocSanPham.fromJson(Map<String, dynamic> json) {
    return KichThuocSanPham(
      id: json['id'],
      tenKichThuoc: json['ten_kich_thuoc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_kich_thuoc': tenKichThuoc,
    };
  }
}
