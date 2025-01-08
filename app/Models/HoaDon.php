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
    protected $fillable = ['KhachHang_Id', 'HinhThucThanhToan_Id', 'ngay_lap', 'id_Ma_Giam_Gia'];

    // Quan hệ với bảng chi tiết hóa đơn
    public function chitiethoadons()
    {
        return $this->hasMany(ChiTietHoaDon::class, 'HoaDon_Id', 'HoaDon_Id');
    }
}
