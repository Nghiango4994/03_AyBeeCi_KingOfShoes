class ChiTietHoaDon {
  final int cthdId; // CTHD_Id
  final int hoaDonId; // HoaDon_Id
  final int bienTheId; // BienThe_Id
  final int soLuong; // SoLuong

  ChiTietHoaDon({
    required this.cthdId,
    required this.hoaDonId,
    required this.bienTheId,
    required this.soLuong,
  });

  // Phương thức để chuyển đổi từ JSON sang đối tượng
  factory ChiTietHoaDon.fromJson(Map<String, dynamic> json) {
    return ChiTietHoaDon(
      cthdId: json['CTHD_Id'],
      hoaDonId: json['HoaDon_Id'],
      bienTheId: json['BienThe_Id'],
      soLuong: json['SoLuong'],
    );
  }

  // Phương thức để chuyển đổi từ đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'CTHD_Id': cthdId,
      'HoaDon_Id': hoaDonId,
      'BienThe_Id': bienTheId,
      'SoLuong': soLuong,
    };
  }
}
