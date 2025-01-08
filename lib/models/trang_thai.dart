class TrangThai {
  final int id;
  final String tenTrangThai;

  TrangThai({required this.id, required this.tenTrangThai});

  // Phương thức để chuyển đổi từ JSON sang đối tượng TrangThai
  factory TrangThai.fromJson(Map<String, dynamic> json) {
    return TrangThai(
      id: json['id'],
      tenTrangThai: json['ten_trang_thai'],
    );
  }

  // Phương thức để chuyển đổi từ đối tượng TrangThai sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_trang_thai': tenTrangThai,
    };
  }
}
