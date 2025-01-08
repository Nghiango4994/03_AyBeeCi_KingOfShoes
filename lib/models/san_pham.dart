// lib/models/san_pham.dart
class SanPham {
  int id;
  String ten;
  int? loaiId;
  int? mauId;
  int? kichThuocId;
  int soLuong;
  double gia;
  String? moTa;
  int? maGiamGia;
  double? giaSauGiam;
  int? nhaCungCapId;
  String? idAnh;
  String? trangThaiSp;

  SanPham({
    required this.id,
    required this.ten,
    this.loaiId,
    this.mauId,
    this.kichThuocId,
    required this.soLuong,
    required this.gia,
    this.moTa,
    this.maGiamGia,
    this.giaSauGiam,
    this.nhaCungCapId,
    this.idAnh,
    this.trangThaiSp,
  });

  // Phương thức từ JSON
  factory SanPham.fromJson(Map<String, dynamic> json) {
    return SanPham(
      id: json['id'],
      ten: json['ten'],
      loaiId: json['loai_id'],
      mauId: json['mau_id'],
      kichThuocId: json['kich_thuoc_id'],
      soLuong: json['so_luong'],
      gia: json['gia'].toDouble(), // Chuyển đổi sang double
      moTa: json['mo_ta'],
      maGiamGia: json['ma_giam_gia'],
      giaSauGiam: json['gia_sau_giam']
          ?.toDouble(), // Chuyển đổi sang double nếu không null
      nhaCungCapId: json['nha_cung_cap_id'],
      idAnh: json['id_anh'],
      trangThaiSp: json['trang_thai_sp'],
    );
  }

  // Phương thức chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': ten,
      'loai_id': loaiId,
      'mau_id': mauId,
      'kich_thuoc_id': kichThuocId,
      'so_luong': soLuong,
      'gia': gia,
      'mo_ta': moTa,
      'ma_giam_gia': maGiamGia,
      'gia_sau_giam': giaSauGiam,
      'nha_cung_cap_id': nhaCungCapId,
      'id_anh': idAnh,
      'trang_thai_sp': trangThaiSp,
    };
  }
}
