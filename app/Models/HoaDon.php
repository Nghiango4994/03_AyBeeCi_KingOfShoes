<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\ChiTietHoaDon;
class HoaDon extends Model {
    use HasFactory;

    // Tắt timestamps nếu không có created_at và updated_at
    public $timestamps = false;

    // Tên bảng trong cơ sở dữ liệu
    protected $table = 'hoa_don';

    // Khóa chính
    protected $primaryKey = 'HoaDon_Id';

    // Danh sách các cột có thể gán hàng loạt
    protected $fillable = ['HoaDon_Id,','KhachHang_Id', 'HinhThucThanhToan_Id', 'ngay_lap', 'id_Ma_Giam_Gia','trang_thai_van_chuyen','trang_thai_thanh_toan'];

    
}
