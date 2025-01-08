class MaGiamGia {
  final int id;
  final String chuoiGiamGia;
  final double giaTriGiam;
  final DateTime ngayHetHan;
  final int? loaiGiamGiaId;
  final int soLuong;

  MaGiamGia({
    required this.id,
    required this.chuoiGiamGia,
    required this.giaTriGiam,
    required this.ngayHetHan,
    this.loaiGiamGiaId,
    required this.soLuong,
  });

  factory MaGiamGia.fromJson(Map<String, dynamic> json) {
    return MaGiamGia(
      id: json['id'],
      chuoiGiamGia: json['ChuoiGiamGia'],
      giaTriGiam: json['GiaTriGiam'].toDouble(),
      ngayHetHan: DateTime.parse(json['NgayHetHan']),
      loaiGiamGiaId: json['LoaiGiamGiaId'],
      soLuong: json['SoLuong'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ChuoiGiamGia': chuoiGiamGia,
      'GiaTriGiam': giaTriGiam,
      'NgayHetHan': ngayHetHan.toIso8601String(),
      'LoaiGiamGiaId': loaiGiamGiaId,
      'SoLuong': soLuong,
    };
  }
}
