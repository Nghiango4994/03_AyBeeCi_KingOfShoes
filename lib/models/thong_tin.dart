class ThongTin {
  int id;
  String? ten;
  String? email;
  DateTime? ngaySinh;
  String? diaChi;
  String? sdt;
  String? matKhau;
  bool locked;
  bool isAdmin;

  ThongTin({
    required this.id,
    this.ten,
    this.email,
    this.ngaySinh,
    this.diaChi,
    this.sdt,
    this.matKhau,
    this.locked = false,
    this.isAdmin = false,
  });

  // Phương thức từ JSON
  factory ThongTin.fromJson(Map<String, dynamic> json) {
    return ThongTin(
      id: json['id'],
      ten: json['ten'],
      email: json['email'],
      ngaySinh:
          json['ngay_sinh'] != null ? DateTime.parse(json['ngay_sinh']) : null,
      diaChi: json['dia_chi'],
      sdt: json['sdt'],
      matKhau: json['mat_khau'],
      locked: json['locked'] == 1, // Chuyển đổi từ TINYINT(1)
      isAdmin: json['isAdmin'] == 1, // Chuyển đổi từ TINYINT(1)
    );
  }

  // Phương thức chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': ten,
      'email': email,
      'ngay_sinh': ngaySinh?.toIso8601String(),
      'dia_chi': diaChi,
      'sdt': sdt,
      'mat_khau': matKhau,
      'locked': locked ? 1 : 0,
      'isAdmin': isAdmin ? 1 : 0,
    };
  }
}
