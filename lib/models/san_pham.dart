class SanPham {
  final int id;
  final String ten;
  final double gia;
  final String idAnh;

  SanPham({
    required this.id,
    required this.ten,
    required this.gia,
    required this.idAnh,
  });

  factory SanPham.fromJson(Map<String, dynamic> json) {
    return SanPham(
      id: json['id'] ?? 0,
      ten: json['ten'] ?? '',
      gia: double.tryParse(json['gia'] ?? '0') ?? 0.0,
      idAnh: json['id_anh']['duong_dan_anh'] ?? '',
    );
  }
}
