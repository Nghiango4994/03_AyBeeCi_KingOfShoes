import 'dart:ffi';

class AnhSp {
  final int id;
  final String duong_dan_anh;
  final int id_BienThe;

  AnhSp({
    required this.id,
    required this.duong_dan_anh,
    required this.id_BienThe,
  });

  factory AnhSp.fromJson(Map<String, dynamic> json) {
    return AnhSp(
      id: json['id'] ?? 0,
      duong_dan_anh: json['duong_dan_anh'] ?? '',
      id_BienThe: json['id_BienThe'] ?? 0,
    );
  }
}
