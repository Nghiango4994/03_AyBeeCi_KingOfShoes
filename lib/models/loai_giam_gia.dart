class LoaiGiamGia {
  final int id;
  final String tenLoai;

  LoaiGiamGia({required this.id, required this.tenLoai});

  factory LoaiGiamGia.fromJson(Map<String, dynamic> json) {
    return LoaiGiamGia(
      id: json['Id'],
      tenLoai: json['TenLoai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'TenLoai': tenLoai,
    };
  }
}
