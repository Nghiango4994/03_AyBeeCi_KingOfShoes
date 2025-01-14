class HoaDon {
  int? hoaDonId;
  int? khachHangId;
  int? hinhThucThanhToan;
  DateTime? ngayLap;
  int? idMaGiamGia;

  HoaDon({
    this.hoaDonId,
    this.khachHangId,
    this.hinhThucThanhToan,
    this.ngayLap,
    this.idMaGiamGia,
  });

  factory HoaDon.fromJson(Map<String, dynamic> json) {
    return HoaDon(
      hoaDonId: json['hoa_don_id'] as int?,
      khachHangId: json['khach_hang_id'] as int?,
      hinhThucThanhToan: json['hinh_thuc_thanh_toan'] as int?,
      idMaGiamGia: json['id_ma_giam_gia'] as int?,
      ngayLap:
          json['ngay_lap'] != null ? DateTime.tryParse(json['ngay_lap']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hoa_don_id': hoaDonId,
      'khach_hang_id': khachHangId,
      'hinh_thuc_thanh_toan': hinhThucThanhToan,
      'id_ma_giam_gia': idMaGiamGia,
      'ngay_lap': ngayLap?.toIso8601String(),
    };
  }
}
